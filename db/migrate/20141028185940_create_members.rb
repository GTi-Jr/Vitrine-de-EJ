class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.belongs_to :junior_enterprises
      t.string :name
      t.string :photo
      t.string :position

      t.timestamps
    end
  end
end
