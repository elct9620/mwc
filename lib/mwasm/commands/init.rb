# frozen_string_literal: true

require 'mwasm/utils/command'
require 'mwasm'

module Mwasm
  module Commands
    # Create a new project
    class Init < Thor::Group
      include Thor::Actions
      include Utils::Command

      name 'init'
      usage 'init NAME'
      description 'create a new project'
      display_on { !Mwasm.config.exist? }
      argument :name, type: :string, desc: 'project name'

      def create_project
        empty_directory(name)
        self.destination_root = name
        Mwasm.root = destination_root
      end

      # :nodoc:
      def create_mwasmrc
        template('mwasmrc.erb', '.mwasmrc')
      end

      # :nodoc:
      def setup_project
        empty_directory('vendor')
        empty_directory('dist')
        empty_directory('src/js')
        copy_file('config/build.rb')
        copy_file('.gitignore')
      end

      # :nodoc:
      def download_mruby
        Mwasm.config.reload!
        # TODO: Allow choose download mode
        inside(mruby_directory.dirname) do
          run("curl -OL #{archive_url}")
          run("tar -zxf #{filename}")
          remove_file(filename)
          run("mv mruby-#{version} #{mruby_directory}")
        end
      end

      private

      def version
        Mwasm.config.mruby.version
      end

      # :nodoc:
      def archive_url
        "https://github.com/mruby/mruby/archive/#{filename}"
      end

      # :nodoc:
      def filename
        "#{version}.tar.gz"
      end

      def mruby_directory
        Mwasm.config.mruby.path
      end
    end
  end
end
