class AddAreaToJuniorEnterprises < ActiveRecord::Migration
  def change
    add_column :junior_enterprises, :area, :string
  end
end
