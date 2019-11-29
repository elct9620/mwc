# frozen_string_literal: true

require 'thor/rake_compat'

require 'masm/utils/command'
require 'masm/tasks'
require 'masm'

module Masm
  module Commands
    # Compile mruby to wasm
    class Compile < Thor::Group
      include Utils::Command

      name 'compile'
      description 'compile source code to wasm'
      display_on { Masm.config.exist? }
      add_option :format, default: 'html', enum: %w[html js wasm]

      def compile
        Tasks.new
        Rake::Task[parent_options['format']].invoke
      end
    end
  end
end
