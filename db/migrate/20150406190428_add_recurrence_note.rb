# frozen_string_literal: true

class AddRecurrenceNote < ActiveRecord::Migration
  def self.up
    add_column :recurrences, :note, :string
  end

  def self.down
    remove_column :recurrences, :note
  end
end
