class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :logo
      t.string :name
      t.string :opening_hours
      t.string :address
      t.float :lat
      t.float :long
      t.references :owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
