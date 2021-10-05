# frozen_string_literal: true

require 'singleton'
require 'digest/md5'

module Authorizer
  module Data
    module Manager
      ##
      # This class manage transaction-type <--> subtacks 
      # to later build the transaction to be executed.

      class Transaction
        include Singleton

        def add_tasks_for(transaction, &tasks_block)
          tasks[transaction] = tasks_block
        end

        def get_tasks_for(transaction)
          tasks[transaction]
        end

        # TODO: 
        #   Instead of receiving the json object with the operation data
        #   lets expect a 'Operation' class type object.
        #   
        #   Operation.type -> transaction.type 
        #   Operation.data -> transaction.operation_data

        def build(operation, entity_class)
          checksum = gen_checksum(operation)
          transaction_type = operation.keys.first
          transaction_data = operation[transaction_type]
          transaction_tasks = get_tasks_for(transaction_type)
          transaction_entity = entity_class.new(transaction_type, transaction_data, &transaction_tasks)
          return transaction_entity, :double_transaction if operations.key?(checksum)
          operations[checksum] = transaction_entity
        end

        private
        def gen_checksum(operation)
          Digest::MD5.hexdigest(operation.to_s.chars.sort.join) 
        end

        def operations
          @operations ||= {}
        end

        def tasks
          @tasks ||= {}
        end

      end
    end
  end
end
