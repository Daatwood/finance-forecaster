class AddWebsiteToBill < ActiveRecord::Migration
  def change
    add_column :bills, :website, :string
  end
end
