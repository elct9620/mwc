# frozen_string_literal: true

require 'masm'

module Masm
  module Utils
    # The command extensions
    module Command
      # :nodoc:
      def self.included(base)
        base.extend ClassMethods
      end

      # :nodoc:
      module ClassMethods
        # Get or set command name
        #
        # @param name [String] the command name
        #
        # @since 0.1.0
        # @api private
        def name(name = nil)
          return @name || self.name.split('::').last.downcase if name.nil?

          @name = name
        end

        # Get or set command description
        #
        # @param desc [String] the command description
        #
        # @since 0.1.0
        # @api private
        def description(desc = nil)
          return @description || name if desc.nil?

          @description = desc
        end

        # The command should display or not
        #
        # @return [TrueClass,FalseClass] display on command
        #
        # @since 0.1.0
        # @api private
        def display?
          return true if @display.nil?

          @display.call
        end

        # Define the command display policy
        #
        # @param proc [Proc] the display policy block
        #
        # @since 0.1.0
        # @api private
        def display_on(&block)
          return unless block_given?

          @display = block
        end

        # The thor template source root
        #
        # @see Masm.source_root
        #
        # @return [String] the source root path
        #
        # @since 0.1.0
        # @api private
        def source_root
          Masm.source_root
        end
      end
    end
  end
end
