class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :photo
      t.string :position
      t.integer :junior_enterprise_id
      t.timestamps
    end
    add_index :members, :junior_enterprise_id
  end
end
