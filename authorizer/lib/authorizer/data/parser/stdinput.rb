# frozen_string_literal: true

require 'singleton'
require 'json'

module Authorizer
  module Data
    module Parser
      class StdInput
        include Singleton

        def get_json
          filecontent.map { |line| JSON.load(line) }
        end

        private

        def filecontent
          @filecontent ||= ARGF.readlines
        end
      end
    end
  end
end
