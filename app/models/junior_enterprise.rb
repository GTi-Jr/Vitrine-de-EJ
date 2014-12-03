class JuniorEnterprise < ActiveRecord::Base
	before_create { set_to_zero(:access) }

  belongs_to :user	 
	has_many :members
	has_many :messages	
	mount_uploader :logo, ImageUploader

	validates :name, :presence => true
	validates :name, :uniqueness => true
	validates :description, :presence => true
	validates :city, :presence => true
	validates :state, :presence => true
	validates :course, :presence => true

	/Auto zerando contador ao criar/
  def set_to_zero(column)
    self[column] = 0 
  end

end
