class AddUserIdToRestaurants < ActiveRecord::Migration
  def change
    add_reference :restaurants, :users, index: true
  end
end
