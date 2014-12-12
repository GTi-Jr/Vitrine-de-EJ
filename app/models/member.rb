class Member < ActiveRecord::Base
	mount_uploader :photo, ImageUploader	
	skip_callback :commit, :after, :remove_photo!
end
