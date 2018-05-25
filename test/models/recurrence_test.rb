# frozen_string_literal: true

require 'test_helper'

class RecurrenceTest < ActiveSupport::TestCase
  test 'should not save without frequency, active_at, bill, interval' do
    recurrence = Recurrence.new
    assert_not recurrence.valid?
    assert_equal %i[frequency active_at interval bill], recurrence.errors.keys
  end

  test 'normalize frequency' do
    bill = Bill.create(summary: 'test', bill_type: 'income')
    recurrence = Recurrence.new(frequency: '   oNcE  ', active_at: Date.current, amount: 100, interval: 1, bill: bill)
    assert recurrence.valid?
    assert_equal recurrence.frequency, 'once'
  end

  test 'negative amount when bill is expense' do
    bill = Bill.create(summary: 'test', bill_type: 'expense')
    recurrence = Recurrence.new(frequency: '   oNcE  ', active_at: Date.current, amount: 100, interval: 1, bill: bill)
    assert recurrence.valid?
    assert_equal recurrence.amount, -100
  end
end
