class AddConsultorAndProductAndAccessToJuniorEnterprise < ActiveRecord::Migration
  def change
    add_column :junior_enterprises, :consultor, :boolean
    add_column :junior_enterprises, :product, :boolean
    add_column :junior_enterprises, :access, :integer
  end
end
