# frozen_string_literal: true

require 'forwardable'
require 'singleton'

require 'masm/project'
require 'masm/mruby'
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

    attr_reader :project, :mruby

    # :nodoc:
    def initialize
      @path = Masm.root.join('.masmrc')
      @project = Project.new
      @mruby = MRuby.new

      load_config if exist?
    end

    # TODO: Move to DSL module
    # Set name
    #
    # @param name [String|NilClass] the name
    #
    # @since 0.1.0
    # @api private
    def name(name = nil)
      return @name if name.nil?

      @name = name.to_s
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
    def reload!
      # TODO: Update path when root changed
      @path = Masm.root.join('.masmrc')
      return unless exist?

      load_config
    end

    private

    # Laod .masmrc config
    #
    # @since 0.1.0
    # @api private
    def load_config
      # TODO: Improve config DSL
      instance_eval(@path.read)
    end
  end
end
