# frozen_string_literal: true

class AddUserBankIndex < ActiveRecord::Migration
  def change
    add_index :banks, :user_id, unique: true
  end
end
