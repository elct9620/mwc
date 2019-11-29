# frozen_string_literal: true

require 'mwc/utils/option'

module Mwc
  module Options
    # The project related options
    class Project
      include Utils::Option

      option :name
      option :source_map, type: :bool
      option :shell, type: :path
      option :options, array: true
    end
  end
end
