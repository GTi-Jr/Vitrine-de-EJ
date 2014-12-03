class AddPhoneAndEmailToMembers < ActiveRecord::Migration
  def change
    add_column :members, :phone, :string
    add_column :members, :email, :string
  end
end
