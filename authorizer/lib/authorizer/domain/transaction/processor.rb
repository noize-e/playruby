# frozen_string_literal: true

require 'misc/ext/iterator'

include Authorizer::Misc::Ext

module Authorizer
  module Domain
    module Transaction
      class Processor
        attr_reader :transaction

        def initialize(operations)
          @operations = operations
        end

        def load_transaction(entity)
          @transaction, @flags = entity.call(current_operation)
        end

        def skip_transaction?
          not @flags.nil? and @flags == :double_transaction
        end

        def skipped_transaction
          @transaction.get_tasks_data[:violations] << @flags
          @transaction.get_tasks_data
        end

        def current_operation
          operation.get
        end

        def next_operation
          operation.next
        end

        def operation
          @operation ||= Iterator.klass.new(@operations)
        end
      end
    end
  end
end
