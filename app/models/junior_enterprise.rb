class JuniorEnterprise < ActiveRecord::Base
	has_one :user
	has_many :members
end
