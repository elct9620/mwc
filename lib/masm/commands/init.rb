# frozen_string_literal: true

require 'masm/utils/command'
require 'masm'

module Masm
  module Commands
    # Create a new project
    class Init < Thor::Group
      include Thor::Actions
      include Utils::Command

      name 'init'
      description 'create a new project'

      # TODO: Add create project directory support

      # :nodoc:
      def create_masmrc
        template('masmrc.erb', '.masmrc')
      end

      # :nodoc:
      def setup_project
        empty_directory('vendor')
        empty_directory('src/js')
        copy_file('config/build.rb')
        copy_file('.gitignore')
      end

      # :nodoc:
      def download_mruby
        Masm.config.reload!
        # TODO: Allow choose download mode
        inside('vendor') do
          run("curl -OL #{archive_url}")
          run("tar -zxf #{filename}")
          remove_file(filename)
          run("mv mruby-#{Masm.config.mruby[:version]} mruby")
        end
      end

      private

      # :nodoc:
      def archive_url
        "https://github.com/mruby/mruby/archive/#{filename}"
      end

      # :nodoc:
      def filename
        "#{Masm.config.mruby[:version]}.tar.gz"
      end
    end
  end
end
