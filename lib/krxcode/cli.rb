require 'krxcode'
require 'thor'
require 'krxcode/generator'

module Krxcode
  class CLI < Thor
    package_name "KRXcode"

    desc "version", "KRXcode version."
    def version
      puts Krxcode::VERSION
    end

    register(Generator, "generate", "generate [COMMAND]", "generate commands.", alias: "g")
  end
end
