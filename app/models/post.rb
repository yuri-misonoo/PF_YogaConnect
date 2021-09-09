class Post < ApplicationRecord

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :body, presence: true, length: { minimum: 10, maximum: 150 }

  def post_time
    created_at.strftime("%Y/%m/%d")
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
