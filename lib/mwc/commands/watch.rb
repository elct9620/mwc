# frozen_string_literal: true

require 'listen'

require 'mwc/utils/command'
require 'mwc/tasks'
require 'mwc'

module Mwc
  module Commands
    # :nodoc:
    class Watch < Thor::Group
      include Thor::Actions
      include Utils::Command

      name 'watch'
      description 'watch src changes and auto re-compile'
      add_option :format, default: 'html', enum: %w[html js wasm]

      DESIRE_FILES = /\.(h|c|cpp|js)$/.freeze

      def prepare
        @stopped = false
        @dirs = [
          Mwc.root.join('src'),
          Mwc.root.join('include')
        ].map(&:to_s)
      end

      def setup_tasks
        Tasks.new
      end

      def setup_listener
        @listener = Listen.to(*@dirs, only: DESIRE_FILES) do |*_|
          Mwc.use(parent_options['env']) do
            # TODO: Allow change output directory
            empty_directory('dist')

            compile
          end
        end
      end

      def start
        puts 'Starting watch file changes...'
        @listener.start

        Signal.trap(:INT) { exit }
        sleep
      end

      private

      def task
        Rake::Task[parent_options['format']]
      end

      def compile
        task.invoke
        puts 'Compiled!'
      rescue RuntimeError
        puts 'Compile Failed'
      ensure
        reset
      end

      def reset
        task.all_prerequisite_tasks.each(&:reenable)
        task.reenable
      end
    end
  end
end
