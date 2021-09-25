class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  has_many :notofications, dependent: :destroy

  validates :message, presence: true, length: { maximum: 150 }, obscenity: { sanitize: true }
  

end
