require 'abstract_unit'
require 'as/notifications'
require 'as/notifications/instrumenter'

module AS
  module Notifications
    class InstrumenterTest < ActiveSupport::TestCase
      class TestNotifier
        attr_reader :starts, :finishes

        def initialize
          @starts   = []
          @finishes = []
        end

        def start(*args);  @starts << args; end
        def finish(*args); @finishes << args; end
      end

      attr_reader :instrumenter, :notifier, :payload

      def setup
        super
        @notifier     = TestNotifier.new
        @instrumenter = Instrumenter.new @notifier
        @payload      =  { :foo => Object.new }
      end

      def test_instrument
        called  = false
        instrumenter.instrument("foo", payload) {
          called = true
        }

        assert called
      end

      def test_start
        instrumenter.start("foo", payload)
        assert_equal [["foo", instrumenter.id, payload]], notifier.starts
        # Changed from assert_predicate to assert_equal for 1.8 compat.
        assert_equal true, notifier.finishes.empty?
      end

      def test_finish
        instrumenter.finish("foo", payload)
        assert_equal [["foo", instrumenter.id, payload]], notifier.finishes
        # Changed from assert_predicate to assert_equal for 1.8 compat.
        assert_equal true, notifier.starts.empty?
      end
    end
  end
end
