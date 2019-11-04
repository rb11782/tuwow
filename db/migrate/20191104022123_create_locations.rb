class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.text :comment
      t.integer :user_id
      t.integer :wow_id
      t.timestamps
    end
    add_index :locations, :user_id
    add_index :locations, :wow_id
  end
end
