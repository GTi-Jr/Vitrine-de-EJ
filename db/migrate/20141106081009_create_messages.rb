class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.string :email
      t.string :phone
      t.string :name
      t.integer :junior_enterprise_id

      t.timestamps
    end
    add_index :messages, :junior_enterprise_id
  end
end
