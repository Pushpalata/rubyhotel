class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable
  validates :access_token, uniqueness: true

  before_save :ensure_access_token

  def ensure_access_token
    if access_token.blank?
      # assign Access token
      self.access_token = generate_access_token
    end
  end
 
  private
  
  def generate_access_token
    # Get Unique Access token
    loop do
      token = Devise.friendly_token
      break token unless User.where(access_token: token).first
    end
  end     

end
