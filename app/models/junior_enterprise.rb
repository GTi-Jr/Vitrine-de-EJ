class JuniorEnterprise < ActiveRecord::Base
    belongs_to :junior_enterprise
	has_many :members
	has_many :messages	
	mount_uploader :logo, ImageUploader
end
