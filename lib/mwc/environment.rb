# frozen_string_literal: true

require 'mwc/options/project'
require 'mwc/options/mruby'

module Mwc
  # The compile environment manager
  #
  # @since 0.3.0
  # @api private
  class Environment
    # @since 0.3.0
    # @api private
    attr_reader :project, :mruby

    # @since 0.3.0
    # @api private
    def initialize(parent = nil, &block)
      @parent = parent
      @environments = {}
      @project = Options::Project.new(parent&.project)
      @mruby = Options::MRuby.new(parent&.mruby)
      instance_exec(self, &block) if block_given?
    end

    # Define new environment
    #
    # @param name [Symbol] the environment name
    # @param block [Proc] the environment config block
    #
    # @since 0.3.0
    # @api private
    def env(name, &block)
      return if @parent

      @environments[name] = Environment.new(self, &block)
    end
  end
end
