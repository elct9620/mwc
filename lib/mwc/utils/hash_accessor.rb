# frozen_string_literal: true

module Mwc
  module Utils
    # Provide Hash-like accessor
    module HashAccessor
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
    end
  end
end
