class CreateExclusions < ActiveRecord::Migration
  def change
    create_table :exclusions do |t|
      t.datetime "date"
      t.timestamps
    end
  end
end
