class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  attachment :profile_image
  
  has_many :posts
  has_many :health_logs
  
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :introduction, length: { maximum: 70 }
  
end