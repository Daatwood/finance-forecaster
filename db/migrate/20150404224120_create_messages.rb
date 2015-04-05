class CreateMessages < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :public, default: false
    end

  end
end
