# frozen_string_literal: true

require 'misc/ext/tasks_pipeline'
require 'misc/ext/observable'

include Authorizer::Misc::Ext

module Authorizer
  module Data
    module Entity
      ##
      # This class represent a Transaction(operation) of any kind
      # 
      # Provides an interface with observer/publiser and sub task pipeline 
      # execution capabilities.

      class Transaction
        include Publisher
        include TasksPipeline

        attr_accessor :type, :data

        def initialize(type, data, &block)
          @type = type
          @data = data
          instance_eval(&block) if block_given?
        end

        def execute
          execute_first_task do
            notify_observers
          end
        end

        def update(observer)
          get_event_listener(get_status).call(get_tasks_data)
        end
      end
    end
  end
end
