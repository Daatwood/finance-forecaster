# frozen_string_literal: true

class AddExampleData
  include Service

  def initialize(user)
    @user = user
  end

  def call
    @user.bank.bills.create([
                              {
                                summary: 'Monthly Expense Example',
                                bill_type: 'expense',

                                recurrences_attributes: [{
                                  interval: 1,
                                  active_at: Date.current + 7.days,
                                  frequency: 'monthly',
                                  amount: 1870
                                }]
                              }, {
                                summary: 'Bi-Weekly Income Example',
                                bill_type: 'income',
                                recurrences_attributes: [{
                                  interval: 2,
                                  active_at: Date.current + 2.days,
                                  frequency: 'weekly',
                                  amount: 2930
                                }]
                              }, {
                                summary: 'Weekly Expense Example',
                                bill_type: 'expense',
                                recurrences_attributes: [{
                                  interval: 1,
                                  active_at: Date.current + 11.days,
                                  frequency: 'weekly',
                                  amount: 390
                                }]
                              }, {
                                summary: 'Quarterly Expense Example',
                                bill_type: 'expense',
                                recurrences_attributes: [{
                                  interval: 3,
                                  active_at: Date.current + 8.weeks,
                                  frequency: 'monthly',
                                  amount: 6253
                                }]
                              }
                            ])
  end
end
