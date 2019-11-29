# frozen_string_literal: true

require 'mwc/utils/command'
require 'mwc'

module Mwc
  module Commands
    # Create a new project
    class Init < Thor::Group
      include Thor::Actions
      include Utils::Command

      name 'init'
      usage 'init NAME'
      description 'create a new project'
      display_on { !Mwc.config.exist? }
      argument :name, type: :string, desc: 'project name'

      def create_project
        directory('app', name)
        self.destination_root = name
        Mwc.root = destination_root
      end

      # :nodoc:
      def create_mwcrc
        template('mwcrc.erb', '.mwcrc')
        Mwc.config = Pathname.new(destination_root).join('.mwcrc')
      end

      # :nodoc:
      def download_mruby
        # TODO: Allow choose download mode
        empty_directory('vendor')
        inside(mruby_directory.dirname) do
          run("curl -OL #{archive_url}")
          run("tar -zxf #{filename}")
          remove_file(filename)
          run("mv mruby-#{version} #{mruby_directory}")
        end
      end

      private

      # :nodoc:
      def version
        Mwc.mruby.version
      end

      # :nodoc:
      def archive_url
        "https://github.com/mruby/mruby/archive/#{filename}"
      end

      # :nodoc:
      def filename
        "#{version}.tar.gz"
      end

      # :nodoc:
      def mruby_directory
        Mwc.mruby.path
      end
    end
  end
end
