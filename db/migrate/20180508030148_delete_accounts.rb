# frozen_string_literal: true

class DeleteAccounts < ActiveRecord::Migration
  def up
    drop_table :accounts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
