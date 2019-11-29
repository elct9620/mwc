# frozen_string_literal: true

require 'pathname'

require 'masm/version'
require 'masm/config'

# WebAssembly compile tool for mruby
module Masm
  # The project root
  #
  # @return [Pathname] the root
  #
  # @since 0.1.0
  # @api private
  def self.root
    return Bundler.root if defined?(::Bundler)

    Pathname.pwd
  end

  # The masm config
  #
  # @return [Masm::Config] the config
  #
  # @since 0.1.0
  # @api private
  def self.config
    Masm::Config.instance
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
      .join('masm', 'templates')
      .to_s
  end
end
