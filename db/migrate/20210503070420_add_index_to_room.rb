class AddIndexToRoom < ActiveRecord::Migration[6.1]
  def change
    add_index :rooms, [:user_id, :price]
  end
end
