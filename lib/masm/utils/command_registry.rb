# frozen_string_literal: true

module Masm
  module Utils
    # The helper to register command on thor
    module CommandRegistry
      # :nodoc:
      def self.included(base)
        base.extend ClassMethods
      end

      # :nodoc:
      module ClassMethods
        # Add command to thor
        #
        # @param command [Class] the command to add
        #
        # @since 0.1.0
        # @api private
        def add_command(command)
          return unless command.display?

          command.options.each { |args| method_option(*args) }
          register command,
                   command.name,
                   command.usage,
                   command.description
        end

        # Add subcommand to thor
        #
        # @param command [Class] the subcommand
        #
        # @since 0.1.0
        # @api private
        def add_subcommand(command)
          return unless command.display?

          desc command.usage, command.description
          subcommand command.name, command
        end
      end
    end
  end
end
