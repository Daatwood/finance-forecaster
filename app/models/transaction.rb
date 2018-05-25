# frozen_string_literal: true

class Transaction < ActiveRecord::Base
  default_scope { order('date ASC') }
  belongs_to :bank

  validates_presence_of :date
  validates_presence_of :amount
  validates_presence_of :summary

  before_create :add_time_to_date

  def add_time_to_date
    self.date = date.to_datetime + Time.now.seconds_since_midnight.seconds
  end

  def expense?
    amount < 0
  end

  def income?
    amount > 0
  end
end
