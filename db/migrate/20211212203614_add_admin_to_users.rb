class AddAdminToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin, :bool, default: false
    add_column :users, :customer, :bool, default: false
    add_column :users, :owner, :bool, default: false
    add_column :users, :seller, :bool, default: false
  end
end
