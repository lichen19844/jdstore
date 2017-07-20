class AddUsersCountToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :users_count, :integer, default: 0
  end
end
