class Post < ApplicationRecord

  belongs_to :user

  validates :body, presence: true, length: { minimum: 10, maximum: 150  

  def post_time
    created_at.strftime("%Y/%m/%d")
  end

end
