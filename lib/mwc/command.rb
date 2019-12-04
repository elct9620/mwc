# frozen_string_literal: true

require 'thor'

require 'mwc/utils/command_registry'
require 'mwc/config'
require 'mwc/commands/init'
require 'mwc/commands/compile'
require 'mwc/commands/watch'
require 'mwc/commands/server'

module Mwc
  # :nodoc:
  class Command < Thor
    include Utils::CommandRegistry

    class_option :env, desc: 'the prefer environment'

    desc 'version', 'show version'
    def version
      puts Mwc::VERSION
    end

    add_command Commands::Init
    add_command Commands::Compile
    add_command Commands::Watch
    add_command Commands::Server
  end
end
