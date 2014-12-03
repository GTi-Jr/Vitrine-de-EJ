class Member < ActiveRecord::Base
	mount_uploader :photo, ImageUploader

	validates :name, :presence => true
	validates :name, :uniqueness => true
	validates :email, :presence => true
	validates :email, :uniqueness => true
end
