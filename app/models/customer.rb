class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :cart_items
  has_many :orders

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, presence: true
  
  def activate!
    update(is_active: true)
  end

  def deactivate!
    update(is_active: false)
  end

end
