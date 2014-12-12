class JuniorEnterprise < ActiveRecord::Base
	before_create { set_to_zero(:access) }

  	belongs_to :user	 
	has_many :members
	has_many :messages	

	mount_uploader :logo, ImageUploader
	skip_callback :destroy, :after, :remove_logo!

  /Auto zerando contador ao criar/
  def set_to_zero(column)
    self[column] = 0 
  end

end
