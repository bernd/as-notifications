AS::Notification -- Provides an instrumentation API for Ruby
------------------------------------------------------------

AS::Notification is an extraction of ActiveSupport::Notifications from
[Rails](https://github.com/rails/rails/tree/master/activesupport).

**It will track activesupport 4.x once that's released.**

# Changes to ActiveSupport::Notifications

* Change module name from `ActiveSupport::Notifications` to
  `AS::Notifications` to avoid conflicts with activesupport
* Change `require` calls for `active_support/notifications` to
  `as/notifications`
* Disable loading `load_paths` file in tests
* Revert rails/rails@45448a5 changes to avoid `thread_safe` gem dependency
