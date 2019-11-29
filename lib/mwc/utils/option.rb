# frozen_string_literal: true

module Mwc
  module Utils
    # Extend option class
    module Option
      # :nodoc:
      def self.included(base)
        base.class_eval do
          extend ClassMethods

          def initialize(parent)
            @parent = parent
          end
        end
      end

      # Hash-like getter
      #
      # @param name [String|Symbol] the option name
      #
      # @since 0.3.0
      # @api private
      def [](name)
        return unless respond_to?(name)

        send(name)
      end

      # Hash-like setter
      #
      # @param name [String|Symbol] the option name
      # @param value [Object] the option value
      #
      # @since 0.3.0
      # @api private
      def []=(name, value)
        return unless respond_to?("#{name}=")

        send("#{name}=", value)
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
          case type
          when :path then Mwc.root.join(value)
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
      end
    end
  end
end
