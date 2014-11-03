class User < ActiveRecord::Base
  has_one :junior_enterprise, dependent: :destroy	 
  
  validates :email, :presence => true

  before_create { generate_token(:password) }

  /Método para Gerar Senha Randomica/
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64(6,false)
    end while User.exists?(column => self[column])    
  end

  def is_admin?
  	self.function == "admin" ? true : false
  end
end
