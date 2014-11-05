class UserAddPushover < ActiveRecord::Migration
  def self.up
    add_column :users, :pushover_token, :string
  end

  def self.down
    remove_column :users, :pushover_token
  end
end
