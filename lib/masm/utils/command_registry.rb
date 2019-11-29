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
        # @param [Class] the command to add
        #
        # @since 0.1.0
        # @api private
        def add_command(command)
          return unless command.display?

          register command,
                   command.name,
                   command.name,
                   command.description
        end
      end
    end
  end
end
