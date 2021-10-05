# frozen_string_literal: true

require 'misc/ext/iterator'

include Authorizer::Misc::Ext

module Authorizer
  module Domain
    ##
    # This class provides an interface to
    # manage the transaction router' events

    class RouterProcessor
      include Iterator

      TBEGIN = :tbegin
      TEXEC = :texec
      TEND = :tend

      def setup_processor
        setup_iterator([TBEGIN, TEXEC, TEND])
      end

      def current_stage
        get
      end

      def next_stage
        self.next
      end

      def end_stage
        self.set(2)
      end

      def reset_pointer
        reset
      end
    end
  end
end
