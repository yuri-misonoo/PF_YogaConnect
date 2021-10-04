class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy

  validates :body, presence: true, obscenity: { sanitize: true }

  def comment_time
    created_at.strftime("%Y/%m/%d")
  end

  # 検索機能の定義
  def self.search(body)
    return all unless body
    where(['body LIKE ?', "%#{body}%"])
  end
end
