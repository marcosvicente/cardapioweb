class AddOwnerToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :owner, null: true, foreign_key:  { to_table: :owners }
  end
end
