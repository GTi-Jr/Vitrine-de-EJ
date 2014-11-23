class AddProjectAndTrainingToJuniorEnterprise < ActiveRecord::Migration
  def change
    add_column :junior_enterprises, :project, :boolean
    add_column :junior_enterprises, :training, :boolean
  end
end
