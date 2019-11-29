# frozen_string_literal: true

require 'forwardable'
require 'singleton'

require 'masm'

module Masm
  # The compile preferences
  class Config
    class << self
      extend Forwardable

      delegate %i[
        exist?
        mruby
      ] => :instance
    end

    include Singleton

    attr_reader :mruby

    # :nodoc:
    def initialize
      @path = Masm.root.join('.masmrc')
      @mruby = {} # TODO
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

    private

    # Laod .masmrc config
    #
    # @since 0.1.0
    # @api private
    def load_config
      instance_eval(@path.read)
    end
  end
end
