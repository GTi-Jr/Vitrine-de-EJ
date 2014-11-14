class AddAddressToJuniorEnterprise < ActiveRecord::Migration
  def change
    add_column :junior_enterprises, :address, :string
  end
end
