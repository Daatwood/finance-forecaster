# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

demo = User.create(email: 'demo@finance-forecaster.com', password: ENV["DEMO_PASSWORD"] || 'Password', public: true)
# demo.bank.bills.create([bill_type: ''])