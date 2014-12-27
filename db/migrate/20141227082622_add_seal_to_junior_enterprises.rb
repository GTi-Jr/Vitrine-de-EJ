class AddSealToJuniorEnterprises < ActiveRecord::Migration
  def change
    add_column :junior_enterprises, :seal, :boolean
  end
end
