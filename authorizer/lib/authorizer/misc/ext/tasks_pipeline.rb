# frozen_string_literal: true

require 'misc/ext/iterator'
require 'data/entity/rules/violations'
require 'securerandom'

include Authorizer::Data::Entity::Rules

module Authorizer
  module Misc
    module Ext
      module TasksPipeline
        attr_reader :tasks, :tasks_data

        def execute_first_task(&block)
          @status = :begin
          unless execute_task
            set_completion_status
            block.call(get_tasks_data) if block_given?
          end
        end

        def get_status
          @status 
        end

        def get_tasks_data
          tasks_data
        end

        def tasks
          @tasks ||= Iterator.klass.new([])
        end

        private

        def tasks_data
          @tasks_data ||= { violations: [] }
        end

        def add_task(&task_block)
          tasks.add(task_block)
        end

        def next_task
          tasks.next
        end

        def get_tuuid
          SecureRandom.uuid
        end

        def get_timestamp
          Time.now.getutc
        end

        def execute_task
          return if @tasks.get.nil?
          begin
            @tasks.get.call(self)
          rescue RuleViolation => e
            tasks_data[:violations] << e.message
          end
          return unless tasks_data[:violations].count.zero?
          next_task
          execute_task
        end

        def set_completion_status
          @status = :end
        end
      end
    end
  end
end
