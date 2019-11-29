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
    Mwc::Config.instance
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
end
