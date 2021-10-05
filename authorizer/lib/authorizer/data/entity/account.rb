# frozen_string_literal: true

require 'data/entity/rules/violations'

include Authorizer::Data::Entity::Rules

module Authorizer
  module Data
    module Entity
      class Card
        attr_reader :active, :balance, :credit

        def initialize(active, credit, balance)
          @active = active
          @balance = balance
          @credit = credit
        end

        def withdrawal(merchant, amount, timestamp)
          result = @balance - amount
          raise_violation if result.negative?
          update_balance(result)
        end

        def last_movement
        end

        private
        def update_balance(total)
          @balance = total
        end

        def raise_violation
          raise RuleViolation, AuthorizationViolations::INSUFFICIENT_LIMIT
        end
      end

      ##
      # This class represent a cardHolder's account entity
      #
      # Given its business nature it behaves as a Immutable object

      class Account
        @@instance = nil

        def initialize(active_card, available_limit)
          @active_card = active_card
          @limit = available_limit
        end

        def self.create(*args)
          raise RuleViolation, AccountViolations::ACCOUNT_INITIALIZED unless @@instance.nil?
          @@instance = new(*args)
        end

        def self.instance
          if @@instance.nil?
            raise RuleViolation, AccountViolations::ACCOUNT_NOT_INITIALIZED
          end

          @@instance
        end

        def self.instance!
          if @@instance.nil?
            new(false, 0)
          else
            @@instance
          end
        end

        def get_data
          {
            account: {
              active_card: card.active,
              available_limit: card.balance
            }
          }
        end

        def get_card
          raise RuleViolation, AccountViolations::CARD_NOT_ACTIVE unless card.active
          card
        end

        private
        def card
          @card ||= Card.new(@active_card, @limit, @limit)
        end
      end
    end
  end
end
