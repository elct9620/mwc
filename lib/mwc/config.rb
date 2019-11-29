# frozen_string_literal: true

require 'mwc/environment'
require 'mwc'

module Mwc
  # The compile preferences
  class Config
    # @since 0.3.0
    # @api private
    LOCK = Mutex.new

    # @since 0.3.0
    # @api private
    attr_reader :default

    # :nodoc:
    def initialize(path = Mwc.root.join('.mwcrc'))
      @path = Pathname.new(path)
      @default = Environment.new
      load_config if exist?
    end

    # Check config file exists
    #
    # @return [TrueClass,FalseClass] exist or not
    #
    # @since 0.1.0
    # @api private
    def exist?
      @path.exist?
    end

    # Reload config
    #
    # @since 0.1.0
    # @api private
    def reload
      Mwc.config = Mwc.root.join('.mwcrc')
    end

    private

    # Laod .mwcrc config
    #
    # @since 0.1.0
    # @api private
    def load_config
      LOCK.synchronize { @default.instance_eval(@path.read) }
    end
  end
end
