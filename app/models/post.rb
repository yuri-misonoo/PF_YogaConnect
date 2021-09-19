class Post < ApplicationRecord

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :body, presence: true, length: { minimum: 10, maximum: 150 }, obscenity: { sanitize: true }

  def post_time
    created_at.strftime("%Y/%m/%d")
  end

  #投稿がいいねされているか判断する
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  #通知機能
  def create_notification_favorite!(current_user)
    #いいねを連打しても一回しか通知がいかないようにするため、すでにいいねされているか検索する
    #「?」（プレースホルダ）は、「?」を指定した値で置き換えることができる
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, 'favorite'])
    #いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      #自分の投稿に対するいいねの場合は、通知が来ないように通知済みの設定をする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  #コメントの通知
  def create_notification_comment!(current_user, post_comment_id)
    #自分以外にコメントしている人をすべて取得し、全員に通知を送る
    #複数回コメントを残す場合があるため、いいねのようにレコードの存在チェックはしない
    #投稿にコメントしているユーザーのIDリスト取得。　　　　　自分のコメント除外と重複した場合の削除
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    #まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end


  def save_notification_comment!(current_user, post_comment_id, visited_id)
    #コメントは複数回することが考えられるため、1つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'post_comment'
    )

    #自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  #検索機能の定義
  def self.search(search)
    if search
    Post.where(['body LIKE ?', "%#{search}%"])
    else
      Post.all
    end
  end

end
