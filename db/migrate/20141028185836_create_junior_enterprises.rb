class CreateJuniorEnterprises < ActiveRecord::Migration
  def change
    create_table :junior_enterprises do |t|
      t.string :name
      t.integer :user_id
      t.string :logo
      t.text :description
      t.text :phrase
      t.string :site
      t.string :phone
      t.string :city
      t.string :state
      t.timestamps
    end
    add_index :junior_enterprises, :user_id
  end
end
