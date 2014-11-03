class JuniorEnterprise < ActiveRecord::Base
    belongs_to :junior_enterprise
	has_many :members	
	mount_uploader :logo, ImageUploader
end
