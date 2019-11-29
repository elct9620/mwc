# frozen_string_literal: true

require 'thor'

require 'masm/utils/command_registry'
require 'masm/config'
require 'masm/commands/init'
require 'masm/commands/compile'
require 'masm/commands/server'

module Masm
  # :nodoc:
  class Command < Thor
    include Utils::CommandRegistry

    desc 'version', 'show version'
    def version
      puts Masm::VERSION
    end

    add_command Commands::Init
    add_command Commands::Compile
    add_command Commands::Server
  end
end
