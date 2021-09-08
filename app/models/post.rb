class Post < ApplicationRecord

  belongs_to :user
  has_many :post_comments, dependent: :destroy

  validates :body, presence: true, length: { minimum: 10, maximum: 150 }

  def post_time
    created_at.strftime("%Y/%m/%d")
  end

end
