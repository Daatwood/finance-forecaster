# frozen_string_literal: true

class AddWebsiteToBill < ActiveRecord::Migration
  def change
    add_column :bills, :website, :string
  end
end
