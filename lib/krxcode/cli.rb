require 'krxcode'
require 'thor'

module Krxcode
  class CLI < Thor

    desc "version", "KRXcode version."
    def version
      puts Krxcode::VERSION
    end

    desc "hello_world", "hello world test"
    def hello_world
      puts 'hello ;)'
    end

  end
end
