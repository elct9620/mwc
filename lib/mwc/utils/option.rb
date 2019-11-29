# frozen_string_literal: true

require 'mwc/utils/hash_accessor'

module Mwc
  module Utils
    # Extend option class
    module Option
      # :nodoc:
      def self.included(base)
        base.class_eval do
          extend ClassMethods
          include HashAccessor

          def initialize(parent)
            @parent = parent
          end
        end
      end

      # :nodoc:
      module ClassMethods
        # Define new options
        #
        # @param name [String] the option name
        #
        # @since 0.3.0
        # @api private
        def option(name, options = {})
          return create_array_option(name, options) if options[:array] == true

          option_reader(name, options)
          option_writer(name, options)
        end

        # Cast value to specify type
        #
        # @param value [Object] the origin value
        # @param type [Symbol] the destination type
        #
        # @since 0.3.0
        # @api private
        def cast(value, type)
          return if value.nil?

          case type
          when :path then Mwc.root.join(value)
          when :bool then value == true
          else value
          end
        end

        private

        def option_reader(name, options = {})
          define_method name do
            instance_variable_get("@#{name}") ||
              @parent&.send(name) ||
              self.class.cast(options[:default], options[:type])
          end
        end

        def option_writer(name, options = {})
          define_method "#{name}=" do |value|
            instance_variable_set(
              "@#{name}",
              self.class.cast(value, options[:type])
            )
          end
        end

        def create_array_option(name, options = {})
          define_method name do |value = nil|
            current = instance_variable_get("@#{name}")&.dup || []
            return current.concat(@parent&.send(name) || []).uniq if value.nil?

            current.push self.class.cast(value, options[:type])
            instance_variable_set("@#{name}", current)
          end
        end
      end
    end
  end
end
