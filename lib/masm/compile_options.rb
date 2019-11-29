# frozen_string_literal: true

require 'masm'

module Masm
  # The compile options
  class CompileOptions
    # :nodoc:
    EXTRA_JS_TYPE = {
      library_js: '--js-library',
      pre_js: '--pre-js',
      post_js: '--post-js'
    }.freeze

    # :nodoc:
    def initialize(options = {})
      @options = []

      options.each do |name, value|
        handler = "add_#{name}"
        send(handler, value) if respond_to?(handler)
      end

      output(options[:format])
    end

    # Convert options to string
    #
    # @return [String] the options
    def to_s
      @options.join(' ')
    end

    # Configure extra javacript
    #
    # @since 0.1.0
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
      @options.push "-o dist/#{Masm.config.project.name}.#{format}"
    end
  end
end
