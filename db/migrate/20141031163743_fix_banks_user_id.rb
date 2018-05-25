# frozen_string_literal: true

class FixBanksUserId < ActiveRecord::Migration
  def self.up
    add_column :banks, :user_id, :integer
  end

  def self.down
    remove_column :banks, :user_id
  end
end
