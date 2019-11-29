# frozen_string_literal: true

require 'mwc'

module Mwc
  # The compile options
  class CompileOptions
    # :nodoc:
    EXTRA_JS_TYPE = {
      library_js: '--js-library',
      pre_js: '--pre-js',
      post_js: '--post-js'
    }.freeze

    OPTIONS = %i[shell source_map extra].freeze

    # :nodoc:
    def initialize(options = {})
      @options = []

      options.each do |name, value|
        handler = "add_#{name}"
        send(handler, value) if respond_to?(handler)
      end

      OPTIONS.each { |name| send("setup_#{name}") }
      output(options[:format])
    end

    # Setup shell file
    #
    # @since 0.2.0
    # @api private
    def setup_shell
      return if Mwc.project.shell.nil?

      @options.push "--shell-file #{Mwc.project.shell}"
    end

    # Setup source map
    #
    # @since 0.2.0
    # @api private
    def setup_source_map
      return unless Mwc.project.source_map

      @options.push '-g4 --source-map-base /'
    end

    # Setup extra options
    #
    # @since 0.2.0
    # @api private
    def setup_extra
      return unless Mwc.project.options.any?

      Mwc.project.options.each do |option|
        @options.push option
      end
    end

    # Convert options to string
    #
    # @return [String] the options
    def to_s
      @options.join(' ')
    end

    # Configure extra javacript
    #
    # @since 0.2.0
    # @api private
    %i[library_js pre_js post_js].each do |type|
      define_method "add_#{type}" do |items|
        items.each do |path|
          @options.push "#{EXTRA_JS_TYPE[type]} #{path}"
        end
      end
    end

    private

    # Configure output format
    #
    # @param foramt [String] output format
    #
    # @since 0.1.0
    # @api private
    def output(format)
      @options.push "-o dist/#{Mwc.project.name}.#{format}"
    end
  end
end
