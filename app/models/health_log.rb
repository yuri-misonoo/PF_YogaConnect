class HealthLog < ApplicationRecord
  enum feeling: { とても元気: 0, まあまあ元気: 1, 普通: 2, 少し落ち込んでいる: 3, 落ち込んでいる: 4 }

  belongs_to :user

  def self.search(target_user, search)
    query = HealthLog.where(user_id: target_user.id)
    query.where(['health_log_on LIKE ?', "%#{search}%"]) if search
  end

  # 共通部分を変数に格納し、後置ifを使ってスマートなコードにしたのが上の書き方
  # def self.search(target_user, search)
  #   if search
  #     HealthLog.where(user_id: target_user.id).where(['health_log_on LIKE ?', "%#{search}%"])
  #   else
  #     HealthLog.where(user_id: target_user.id)
  #   end
  # end
end
