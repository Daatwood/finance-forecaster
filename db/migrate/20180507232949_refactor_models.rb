# frozen_string_literal: true

class RefactorModels < ActiveRecord::Migration
  # trimming the fat
  def up
    remove_column :users, :pushover_token
    remove_column :users, :invitation_token
    remove_column :users, :invitation_created_at
    remove_column :users, :invitation_sent_at
    remove_column :users, :invitation_accepted_at
    remove_column :users, :invitation_limit
    remove_column :users, :invited_by_id
    remove_column :users, :invited_by_type
    remove_column :users, :invitations_count
    remove_column :users, :authentication_token
    add_column :banks, :balance, :integer
    remove_column :accounts, :phone
    remove_column :accounts, :address
    remove_column :accounts, :account_number
    remove_column :accounts, :username
    remove_column :accounts, :password
    remove_column :recurrences, :static_amount
    remove_column :bills, :amount
    remove_column :transactions, :bill_id
    drop_table :messages
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
