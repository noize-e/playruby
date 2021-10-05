# frozen_string_literal: true

module Authorizer
  module Misc
    module Ext
      module Iterator
        def setup_iterator(array)
          @array = array
          @index = 0
        end

        def has_next?
          @index < @array.length
        end

        def add((item))
          @array << item
        end

        def get
          @array[@index]
        end

        def set(value)
          @index = value
        end

        def reset
          @index = 0
        end

        def next
          value = @array[@index]
          @index += 1
          value
        end

        def self.klass
          Class.new do
            include Iterator

            def initialize(array)
              setup_iterator(array)
            end
          end
        end
      end
    end
  end
end
