class JuniorEnterprise < ActiveRecord::Base
    belongs_to :user, dependent: :destroy	 
	has_many :members, dependent: :destroy
	has_many :messages	
	mount_uploader :logo, ImageUploader
end
