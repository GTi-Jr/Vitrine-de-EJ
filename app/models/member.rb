class Member < ActiveRecord::Base
	mount_uploader :photo, ImageUploader
end
