class JuniorEnterprise < ActiveRecord::Base
    belongs_to :user	 
	has_many :members
	has_many :messages	
	mount_uploader :logo, ImageUploader
end
