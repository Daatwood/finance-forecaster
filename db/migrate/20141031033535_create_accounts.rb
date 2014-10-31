class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string "name",  :null => false
      t.string "phone"
      t.string "address"
      t.string "account_number"
      t.string "website"
      t.string "username"
      t.string "password"
      t.integer  "user_id"
      t.timestamps
    end

    create_table :bills do |t|
      t.string "type",              :null => false
      t.string "summary",           :null => false
      t.integer "amount",           :default => 0
      t.datetime "active_at"
      t.datetime "expires_at"
      t.integer "account_id"
      t.timestamps
    end

    create_table :payments do |t|
      t.integer "amount"
      t.integer "bill_id"
      t.timestamps
    end

    create_table :recurrences do |t|
      t.string "frequency"
      t.datetime "expires_at"
      t.integer "interval"
    end
  end
end
