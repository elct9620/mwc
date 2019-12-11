# frozen_string_literal: true

require 'rake/tasklib'

require 'mwc/compile_options'
require 'mwc'

module Mwc
  # :nodoc:
  class Tasks < Rake::TaskLib
    SOURCES = FileList['src/**/*.c']
    BINARIES = SOURCES.ext('bc')
    LIBRARY_JS = FileList['src/js/**/*.lib.js']
    PRE_JS = FileList['src/js/**/*.pre.js']
    POST_JS = FileList['src/js/**/*.post.js']

    # :nodoc:
    def initialize
      return unless mruby_directory.join('Rakefile').exist?

      namespace :mruby do
        ENV['MRUBY_CONFIG'] = Mwc.root.join('config', 'build.rb').to_s
        # TODO: Prevent load error breaks command
        load mruby_directory.join('Rakefile')
      end

      compile_binary_task
      compile_wasm_task
    end

    private

    # :nodoc:
    def compile_binary_task
      rule '.bc' => SOURCES do |task|
        sh "emcc -I #{mruby_directory.join('include')} -I include -c " \
           "#{task.source} -o #{task.name}"
      end
    end

    # :nodoc:
    def compile_wasm_task
      %i[wasm html js].each do |format|
        desc "Compile sources to #{format} WebAssembly"
        task format => BINARIES do
          Rake::Task['mruby:all'].invoke
          compile(format)
        end
      end
    end

    # :nodoc:
    def compile(format)
      do_compile CompileOptions.new(
        format: format,
        library_js: LIBRARY_JS,
        pre_js: PRE_JS,
        post_js: POST_JS
      )
    end

    # :nodoc:
    def do_compile(options)
      sh "emcc #{sources.join(' ')} #{options}"
    end

    # :nodoc:
    def libmruby
      mruby_directory.join('build/wasm/lib/libmruby.bc')
    end

    # :nodoc:
    def sources
      [libmruby].concat(BINARIES)
    end

    # :nodoc:
    def mruby_directory
      Mwc.mruby.path
    end
  end
end
