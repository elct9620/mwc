# frozen_string_literal: true

module Mwasm
  # The project settings
  class Project
    attr_accessor :name, :shell, :source_map
    attr_reader :options

    # :nodoc:
    def initialize
      @options = {}
    end

    # Add customize options
    #
    # @param name [String] the option name
    # @param value [String] the option value
    #
    # @since 0.2.0
    # @api private
    def option(name, value)
      @options[name] = value
    end
  end
end
