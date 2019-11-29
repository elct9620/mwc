# frozen_string_literal: true

require 'masm/utils/command'
require 'masm/config'

module Masm
  module Commands
    # Create a new project
    class Init < Thor::Group
      include Thor::Actions
      include Utils::Command

      name 'init'
      description 'create a new project'
      display_on { !Masm::Config.exist? }

      def create_masmrc
        template('masmrc.erb', '.masmrc')
      end
    end
  end
end
