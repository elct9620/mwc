# frozen_string_literal: true

require 'mwc'

module Mwc
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

        # Set command usage
        #
        # @param name [String] the command usage
        #
        # @since 0.1.0
        # @api private
        def usage(usage = nil)
          return @usage || name if usage.nil?

          @usage = usage
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
        # @see Mwc.source_root
        #
        # @return [String] the source root path
        #
        # @since 0.1.0
        # @api private
        def source_root
          Mwc.source_root
        end

        # The command options
        #
        # @since 0.1.0
        # @api private
        def options
          @options ||= []
        end

        # Add command options
        #
        # @param name [String|Symbol] the option name
        # @param options [Hash] the option options
        #
        # @since 0.1.0
        # @api private
        def add_option(name, options = {})
          @options ||= []
          @options.push([name, options])
        end
      end
    end
  end
end
