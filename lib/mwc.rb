# frozen_string_literal: true

require 'pathname'

require 'mwc/version'
require 'mwc/config'

# WebAssembly compile tool for mruby
module Mwc
  # The project root
  #
  # @return [Pathname] the root
  #
  # @since 0.1.0
  # @api private
  def self.root
    return @root unless @root.nil?

    @root ||= Pathname.pwd
    @root ||= Bundler.root if defined?(::Bundler)
    @root
  end

  # Set project root
  #
  # @param path [String|Pathname] the root path
  #
  # @since 0.1.0
  # @api private
  def self.root=(path)
    @root = Pathname.new(path)
  end

  # The mwc config
  #
  # @return [Mwc::Config] the config
  #
  # @since 0.1.0
  # @api private
  def self.config
    @config ||= Config.new
  end

  # Set config
  #
  # @param path [Pathname] the config path
  #
  # @since 0.3.0
  # @api private
  def self.config=(path)
    @config = Config.new(path)
  end

  # The thor template source root
  #
  # @return [String] the source root path
  #
  # @since 0.1.0
  # @api private
  def self.source_root
    Pathname
      .new(File.dirname(__FILE__))
      .join('mwc', 'templates')
      .to_s
  end

  # Current environment
  #
  # @see Mwc::Environment
  #
  # @return [Mwc::Environment] the environment
  #
  # @since 0.3.0
  # @api private
  def self.environment
    # TODO: Switch by environment
    config.default
  end

  # Current mruby preference
  #
  # @return [Mwc::Options::MRuby] the mruby options
  #
  # @since 0.3.0
  # @api private
  def self.mruby
    environment.mruby
  end
end
