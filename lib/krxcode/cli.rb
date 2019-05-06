require 'krxcode'
require 'thor'
require 'krxcode/generator'
require 'xcodeproj'

module Krxcode
  class CLI < Thor
    package_name "KRXcode"

    desc "version", "KRXcode version."
    def version
      puts Krxcode::VERSION
    end

    desc "sort [MyProject.xcodeproj]", "Sort project files"
    def sort file
      project = Xcodeproj::Project.open(file)
      project.sort(groups_position: :above)
      project.save
    end

    register(Generator, "generate", "generate [COMMAND]", "generate commands.", alias: "g")
  end
end
