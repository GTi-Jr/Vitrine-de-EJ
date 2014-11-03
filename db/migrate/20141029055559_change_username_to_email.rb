class ChangeUsernameToEmail < ActiveRecord::Migration
  def change  	
    remove_column :users, :user
    add_column :users, :email, :string
  end
end
