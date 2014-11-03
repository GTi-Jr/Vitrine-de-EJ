class AddTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :function, :string
  end
end
