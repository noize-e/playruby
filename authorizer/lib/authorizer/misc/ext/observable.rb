# frozen_string_literal: true

module Authorizer
  module Misc
    module Ext
      ##
      # Extension module for event pub/sub functionality

      module Observable
        def add_observer(observer)
          observers << observer
        end

        def delete_observer(observer)
          observers.delete(observer)
        end

        def notify_observers
          observers.each do |observer|
            observer.update(self)
          end
        end

        def observers
          @observers ||= []
        end
      end

      ##
      # Extends the observable module functionality to listen to
      # in-house events

      module Publisher
        include Observable

        def setup_publisher
          
        end

        def add_event_listener(event, &callback)
          events[event] = callback
          add_observer(self)
        end

        def get_event_listener(event)
          events[event]
        end

        def events
          @events ||= {}
        end
      end
    end
  end
end
