# frozen_string_literal: true

require 'rake/tasklib'

require 'masm'

module Masm
  # :nodoc:
  class Tasks < Rake::TaskLib
    SOURCES = FileList['src/**/*.c']
    BINARIES = SOURCES.ext('bc')

    # :nodoc:
    def initialize
      return unless Masm.root.join('vendor', 'mruby', 'Rakefile').exist?

      namespace :mruby do
        ENV['MRUBY_CONFIG'] = Masm.root.join('config', 'build.rb').to_s
        # TODO: Prevent load error breaks command
        load Masm.root.join('vendor', 'mruby', 'Rakefile')
      end

      compile_binary_task
      compile_wasm_task
    end

    private

    # :nodoc:
    def compile_binary_task
      rule '.bc' => SOURCES do |task|
        sh 'emcc -I vendor/mruby/include -I include -c ' \
           "#{task.source} -o #{task.name}"
      end
    end

    # :nodoc:
    def compile_wasm_task
      %i[wasm html js].each do |format|
        task "mruby.#{format}" => ['mruby:all'].concat(BINARIES) do
          compile(format)
        end

        desc "Compile sources to #{format} WebAssembly"
        task format => "mruby.#{format}"
      end
    end

    # :nodoc:
    def compile(format)
      libmruby = Masm.root.join('vendor/mruby/build/wasm/lib/libmruby.bc')
      sources = [libmruby].concat(BINARIES)
      # TODO: Load compile options
      sh "emcc #{sources.join(' ')} " \
         "-o dist/#{Masm.config.name}.#{format}"
    end
  end
end
