# frozen_string_literal: true

require 'thor'

require 'mwasm/utils/command_registry'
require 'mwasm/config'
require 'mwasm/commands/init'
require 'mwasm/commands/compile'
require 'mwasm/commands/server'

module Mwasm
  # :nodoc:
  class Command < Thor
    include Utils::CommandRegistry

    desc 'version', 'show version'
    def version
      puts Mwasm::VERSION
    end

    add_command Commands::Init
    add_command Commands::Compile
    add_command Commands::Server
  end
end
