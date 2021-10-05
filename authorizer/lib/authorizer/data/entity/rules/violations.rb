# frozen_string_literal: true

module Authorizer
  module Data
    module Entity
      module Rules
        ##
        # Account operations rules constants

        class AccountViolations
          ACCOUNT_INITIALIZED = :account_already_initialize
          ACCOUNT_NOT_INITIALIZED = :account_not_initialized
          CARD_NOT_ACTIVE = :card_not_active
        end

        ##
        # Authorization operations rules constants

        class AuthorizationViolations
          INSUFFICIENT_LIMIT = :insufficient_limit
        end

        ##
        # This class represent a rule violation in an Authorizer operation.

        class RuleViolation < StandardError; end
      end
    end
  end
end
