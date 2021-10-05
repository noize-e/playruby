# frozen_string_literal: true

require  'config'
require  'data/entity/account'
require  'data/manager/transaction'
require  'data/entity/transaction'
require  'data/parser/stdinput'
require  'domain/transaction/processor'
require  'domain/router'
require 'pp'

include Authorizer::Data
include Authorizer::Domain

module Authorizer
  module Application
    module Layer
      ##
      # Register transactions subtasks sets
      #
      # 1. Account Creation
      #     1.1. Account Validity Verification
      # 2. Transaction Authorization
      #     2.1. Account's Card Validity Verification
      #
      # NOTE: Given the input data keys used in the operations
      # manifest file, the following relation 'key' => 'transaction type'
      # has been established.
      #
      # - Object.key 'account' = Account Creation
      # - Object.key 'transaction' = Transaction Authorization

      def self.run &output
        transaction_manager = Manager::Transaction.instance
        transaction_manager.add_tasks_for 'account' do
          add_task do |ts| # STAGE: Account Verification
            Entity::Account.create(*ts.data.values).get_data
          end
        end
        transaction_manager.add_tasks_for 'transaction' do
          add_task do # STAGE: Account & Card Validity Verification
            @card = Entity::Account.instance.get_card
          end
          add_task do |ts| # STAGE: Card withdrawal
            @card.withdrawal(*ts.data.values)
          end
        end

        # Standard Input file content loader (Maps each line into a JSON object)
        transactions = Parser::StdInput.instance.get_json
        transaction_processor = Transaction::Processor.new(transactions)
        transaction_router = Router.new(transaction_processor)
        transaction_router.add_event_listener :tbegin do |ts|
          transaction_manager.build(ts, Entity::Transaction)
        end
        transaction_router.add_event_listener :texec do |tdata|
          pp Entity::Account.instance!.get_data.merge(tdata)
        end
        transaction_router.start_process
      end
    end
  end
end
