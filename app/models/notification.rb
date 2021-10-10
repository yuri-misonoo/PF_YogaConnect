class Notification < ApplicationRecord
  # デフォルトの並び順を「作成日時の降順」で指定する
  default_scope -> { order(created_at: :desc) }
  # optional: trueはnilを許可するためにつける。必要な情報だけを抜き取るため
  # 例）フォローの通知を送る時はpost_idとpost_cpmment_idの情報はいらないからnilを格納する
  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :room, optional: true
  belongs_to :chat, optional: true

  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true

  # 通知の未確認、確認の切り替え
  def self.check!
    where(checked: false).each do |notification|
      notification.update!(checked: true)
    end
  end


end
