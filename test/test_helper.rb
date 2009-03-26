ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class Test::Unit::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Asserts from Nando Vieira http://pastie.caboo.se/114671

  def logger
    RAILS_DEFAULT_LOGGER
  end

  def ar_error_messages(record)
    record.errors.full_messages.uniq.to_sentence
  end

  def my_assert_valid(record, message=nil)
    message ||= "#{record.class} should be valid\n-- #{ar_error_messages(record)}"
    assert(record.valid?, message)
  end

  def my_assert_invalid(record, message=nil)
    deny(record.valid? && record.save!, "#{record.class} should be invalid\n-- #{ar_error_messages(record)}")
  end

  def my_assert_invalid_on(record, attribute, message=nil)
    my_assert_invalid(record)
    my_assert_error_on(record, attribute)
  end

  def deny(condition, message=nil)
    message ||= " expected but was <#{condition}>"
    assert(!condition, message)
  end

  def my_assert_error_on(record, attribute, message=nil)
    assert(record.errors.invalid?(attribute), "-- #{ar_error_messages(record)}")
    assert(record.errors.on(attribute).include?(message), "#{record.class} should have had the following error:\n- #{message}") if message
  end

  def my_assert_difference(object, attribute, &block)
    original_value = object.send(attribute)
    yield
    assert_not_equal(original_value, object.send(attribute))
  end

  def my_assert_no_difference(object, attribute, &block)
    original_value = object.send(attribute)
    yield
    assert_equal(original_value, object.send(attribute))
  end

  def my_assert_associated(record, attribute)
    # attributes
    attribute = "#{attribute}_id".to_sym if attribute.to_s !~ /_id$/
    relationship = attribute.to_s.gsub(/_id$/, "").to_sym

    # empty
    record.send("#{attribute}=", nil)
    my_assert_invalid_on(record, attribute)
    assert_nil(record.send(relationship))

    # non-number
    record.send("#{attribute}=", "invalid")
    my_assert_invalid_on(record, attribute)
    assert_nil(record.send(relationship))

    # non-existing
    record.send("#{attribute}=", 1000)
    my_assert_invalid_on(record, relationship)
    assert_nil(record.send(relationship))
  end

  def my_assert_inclusion_of(items, search, message=nil)
    message ||= "#{items.inspect} doesn't include #{search.inspect}"
    assert(items.include?(search), message)
  end

  # My asserts
 
  def my_assert_not_inclusion_of(items, search, message=nil)
    message ||= "#{search.inspect} doesn't in #{items.inspect}"
    assert(!items.include?(search), message)
  end
 
end
