class HealthLog < ApplicationRecord

  enum feeling: { とても元気: 0, まあまあ元気: 1, 普通: 2, 少し落ち込んでいる: 3, 落ち込んでいる: 4 }

  belongs_to :user
  
  def self.search(search)
    if search
      HealthLog.where(['health_log_on LIKE ?', "%#{search}%"])
    else
      HealthLog.all
    end
  end

end
