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

            Rake::Task[parent_options['format']].invoke
            puts 'Compiled!'
          end
        end
      end

      def start
        @listener.start

        Signal.trap(:INT) { exit }
        sleep
      end
    end
  end
end
