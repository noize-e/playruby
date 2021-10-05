# frozen_string_literal: true

require 'misc/ext/observable'
require 'domain/router/processor'
require 'singleton'

module Authorizer
  module Domain
    # This class govern the completion, processing and
    # settlement of the transactions procedures
    class Router < RouterProcessor
      include Misc::Ext::Publisher

      def initialize(transaction_processor)
        @transaction_processor = transaction_processor
        setup_processor
      end

      def start_process
        notify_observers
      end

      def update(*)
        case current_stage
        when TBEGIN then tbegin
        when TEXEC then texec
        when TEND then tend
        end
      end

      private

      def tbegin
        processor.load_transaction(callback)
        next_stage
        if processor.skip_transaction?
          callback.call(processor.skipped_transaction)
          end_stage
        end
        notify_observers
      end

      def texec
        processor.transaction.add_event_listener(:end) do |transaction|
          callback.call(transaction)
          next_stage
          notify_observers
        end
        processor.transaction.execute
      end

      def tend
        processor.next_operation
        if processor.current_operation.nil?
          next_stage
        else
          reset_pointer
        end
        notify_observers
      end

      def processor
        @transaction_processor
      end

      def callback
        get_event_listener(current_stage)
      end
    end
  end
end
