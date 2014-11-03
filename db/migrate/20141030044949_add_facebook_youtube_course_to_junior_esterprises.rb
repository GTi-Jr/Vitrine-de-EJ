class AddFacebookYoutubeCourseToJuniorEsterprises < ActiveRecord::Migration
  def change
    add_column :junior_enterprises, :youtube, :string
    add_column :junior_enterprises, :facebook, :string
    add_column :junior_enterprises, :course, :string
  end
end
