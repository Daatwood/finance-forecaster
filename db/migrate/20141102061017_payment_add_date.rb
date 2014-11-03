class PaymentAddDate < ActiveRecord::Migration
  def self.up
    add_column :payments, :date, :datetime
    remove_column :payments, :created_at
    remove_column :payments, :updated_at
  end

  def self.down
    remove_column :payments, :bill_id
    add_column :payments, :created_at, :datetime
    add_column :payments, :updated_at, :datetime
  end
end
