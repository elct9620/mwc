# frozen_string_literal: true

require 'thor/rake_compat'

require 'mwc/utils/command'
require 'mwc/tasks'
require 'mwc'

module Mwc
  module Commands
    # Compile mruby to wasm
    class Compile < Thor::Group
      include Utils::Command

      name 'compile'
      description 'compile source code to wasm'
      display_on { Mwc.config.exist? }
      add_option :format, default: 'html', enum: %w[html js wasm]

      def compile
        Tasks.new
        Rake::Task[parent_options['format']].invoke
      end
    end
  end
end
