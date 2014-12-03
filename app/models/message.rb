class Message < ActiveRecord::Base
	validates :email, :presence => true
	validates :text, :presence => true
end
