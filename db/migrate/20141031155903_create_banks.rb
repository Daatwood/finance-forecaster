class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.integer "balance", default: 0
      t.string "name",  :null => false
      t.timestamps
    end
  end
end
