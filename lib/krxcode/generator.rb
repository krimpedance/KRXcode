require 'erb'
require "fileutils"
require 'pathname'
require 'yaml'
require 'thor'
require 'highline'
require 'xcodeproj'

class Generator < Thor
  package_name "KRXcode"

  desc "project", "generate new project."
  def project
    cli = HighLine.new

    project_name = cli.ask("Project name: ", String)

    if project_name.empty?
      cli.say("<%= color('Enter project name !!', :bold, :red) %>")
      exit!
    end

    bundleid = cli.ask("Bundle ID: ", String) do |q|
      q.default = "com.krimpedance.#{project_name}"
    end

    organization = cli.ask("Organization: ", String) do |q|
      q.default = "Krimpedance"
    end

    architecture = cli.ask("Architecture (mvp|mvvm|clean): ", String) do |q|
      q.in = ["mvp", "mvvm", "clean"]
      q.default = "mvvm"
    end

    database = cli.ask("Database (none|realm|firestore): ", String) do |q|
      q.in = ["none", "realm", "firestore"]
      q.default = "none"
    end

    cli.newline
    cli.say("Generating <%= color('#{project_name}', :bold) %>...")

    project_dir = Pathname.new(Dir.pwd).join(project_name)
    target_dir = project_dir.join(project_name)

    scripts_dir = Pathname.new(__dir__).join("../scripts")
    tmp_project_dir = Pathname.new(__dir__).join("../templates/project")
    tmp_files_dir = Pathname.new(__dir__).join("../templates/files")
    tmp_realm_dir = Pathname.new(__dir__).join("../templates/realm_files")

    # Copy project base
    FileUtils.cp_r("#{tmp_project_dir}", "#{project_dir}")

    # Copy module templates
    FileUtils.cp_r(
      "#{Pathname.new(__dir__).join("../templates/modules").join(architecture)}",
      "#{project_dir.join("Templates")}"
    )

    # Rename
    system("#{scripts_dir}/rename_project.sh '#{project_dir}' '#{bundleid}' '#{organization}'")

    # Copy files by architecture
    project = Xcodeproj::Project.open("#{project_dir.join("#{project_name}.xcodeproj")}")
    target = project.targets.find do |t| t.name == project_name end
    target_group = project[project_name]

    common_pods = []
    main_pods = []
    test_pods = []

    case architecture
    when "mvp"

    when "mvvm"
      common_pods.push("RxSwift", "RxCocoa")
      main_pods.push("RxDataSources")
      test_pods.push("RxTest", "RxBlocking")

    when "clean"
      common_pods.push("RxSwift", "RxCocoa")
      main_pods.push("RxDataSources")
      test_pods.push("RxTest", "RxBlocking")

      make_dir("Framework_Driver", target_dir, target_group)
      make_dir("Gateway", target_dir, target_group)
    end

    case database
    when "none"

    when "realm"
      common_pods.push("RealmSwift")
      common_pods.push("RxRealm") if architecture != "mvp"

      utilities_group = target_group["Utilities"]

      Dir.glob(tmp_realm_dir.join("*")).each do |file|
        erb = ERB.new(IO.read(file), nil, "%")

        original_name = File.basename(file)
        original_name.slice!(".erb")
        original_file = target_dir.join("Utilities/#{original_name}")

        File.open(original_file, "w") do |f|
          f.write(erb.result(binding))
        end

        file_ref = utilities_group.new_file(original_name)
        target.source_build_phase.add_file_reference file_ref
      end

    when "firestore"
      common_pods.push("Firebase/Core", "Firebase/Auth", "Firebase/Firestore")
    end

    Dir.glob(tmp_files_dir.join("*")).each do |file|
      erb = ERB.new(IO.read(file), nil, "%")

      original_name = File.basename(file)
      original_name.slice!(".erb")
      original_file = project_dir.join(original_name)

      File.open(original_file, "w") do |f|
        f.write(erb.result(binding))
      end
    end

    # Sort files
    project.sort(groups_position: :above)
    project.save

    # Make app icon
    script = Pathname.new(__dir__).join("../scripts/make_icon.sh")
    icons_dir = target_dir.join("Resources/Assets.xcassets/AppIcon.appiconset")
    system("#{script} #{icon_text project_name} #{icons_dir}")

    # Permission of setup.sh
    FileUtils.chmod(0755, project_dir.join("setup.sh"))

    cli.say("Completed!! 🍺")
  end

  desc "module [Module name]", "generate new module files."
  option "config", type: :string, default: "KRXcode.yml", bunner: "Path of yml file for configs."
  def module(name)
    cli = HighLine.new

    lower_name = name.tap{ |s| s.sub!(s[0], s[0].downcase) }
    configs = load_yml(options[:config])
    module_path = Pathname.new("#{configs[:gen_root]}").join(name)
    tmp_dir = Pathname.new("#{configs[:tmp_dir]}")
    templates = Dir.glob(tmp_dir.join("*"))

    # Add files
    FileUtils.mkdir_p(module_path)
    FileUtils.cp_r(templates, module_path)
    script = Pathname.new(__dir__).join("../scripts/rename_module.sh")
    system("#{script} '#{module_path}' '#{name}' '#{lower_name}' '#{configs[:target]}' '#{configs[:org]}'")

    # Modify project file

    proj_path = Pathname.new(configs[:proj_root]).join(configs[:proj_name])
    project = Xcodeproj::Project.open(proj_path)
    target = project.targets.find do |t| t.name == configs[:target] end

    if target.nil?
        cli.say("<%= color('[Error] #{configs[:target]}: No such target.', :bold, :red) %>"); exit!
    end

    base_group = File.dirname(module_path).split("/").reduce(project) do |parent, dir|
      dir == "." ?
        parent :
        parent[dir] || parent.new_group(dir)
    end

    add_file(module_path, base_group, target)

    project.sort(groups_position: :above)
    project.save

    system("open #{File.basename(proj_path, ".xcodeproj")}.xcworkspace")
  end

  private

    def load_yml(path)
      cli = HighLine.new

      unless File.exist?(path)
        cli.say("<%= color('[Error] #{path} not found.', :bold, :red) %>"); exit!
      end

      configs = YAML.load_file(path)

      tmp_dir = configs['TemplateDirectory']
      proj_root = configs['ProjectRoot']
      proj_name = configs['ProjectFileName']
      target = configs['Target']
      org = configs['Organization']
      gen_root = configs['GenerateRoot']

      if tmp_dir.nil? or tmp_dir.empty?
        cli.say("<%= color('[Error] TemplateDirectory: Not found.', :bold, :red) %>"); exit!
      elsif !File.exist?(tmp_dir)
        cli.say("<%= color('[Error] #{tmp_dir}: No such directory.', :bold, :red) %>"); exit!
      end

      if proj_root.nil? or proj_root.empty?
        cli.say("<%= color('[Error] ProjectRoot: Not found.', :bold, :red) %>"); exit!
      elsif !File.exist?(proj_root)
        cli.say("<%= color('[Error] #{proj_root}: No such directory.', :bold, :red) %>"); exit!
      end

      if proj_name.nil? or proj_name.empty?
        cli.say("<%= color('[Error] ProjectFileName: Not found.', :bold, :red) %>"); exit!
      elsif !File.exist?(proj_name)
        cli.say("<%= color('[Error] #{proj_name}: No such file.', :bold, :red) %>"); exit!
      end

      if target.nil? or target.empty?
        cli.say("<%= color('[Error] Target: Not found.', :bold, :red) %>"); exit!
      end

      if org.nil? or org.empty?
        cli.say("<%= color('[Error] Organization: Not found.', :bold, :red) %>"); exit!
      end

      if gen_root.nil? or gen_root.empty?
        cli.say("<%= color('[Error] GenerateRoot: Not found.', :bold, :red) %>"); exit!
      elsif !File.exist?(gen_root)
        cli.say("<%= color('[Error] #{gen_root}: No such directory.', :bold, :red) %>"); exit!
      end

      return {
        tmp_dir:    tmp_dir,
        proj_root:  proj_root,
        proj_name:  proj_name,
        target:     target,
        org:        org,
        gen_root:   gen_root
      }
    end

    def add_file path, group, target
      if FileTest.directory?(path)
        group_name = File.basename(path)
        sub_group = group.new_group(group_name, group_name)

        Dir.entries(path).each do |entry|
          next if entry == '.' or entry == '..'
          add_file(path.join(entry), sub_group, target)
        end
      else
        file_name = File.basename(path)
        file = group.new_file(file_name)
        if File.extname(path) == ".swift"
          target.source_build_phase.add_file_reference file
        else
          target.resources_build_phase.add_file_reference file
        end
      end
    end

    def make_dir name, parent_dir, group
      FileUtils.mkdir(parent_dir.join(name))
      group.new_group(name, name)
    end

    def icon_text text
      txt = text.gsub(/[^A-Z]/, "")
      if txt.empty?
        txt = text[0..1]
      elsif txt.length == 1
        txt = text[/[A-Z]./]
      end
      return txt
    end
end
