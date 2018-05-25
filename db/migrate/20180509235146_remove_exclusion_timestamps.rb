# frozen_string_literal: true

class RemoveExclusionTimestamps < ActiveRecord::Migration
  def change
    remove_column :exclusions, :created_at
    remove_column :exclusions, :updated_at
  end
end
