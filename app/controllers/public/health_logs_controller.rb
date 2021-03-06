class Public::HealthLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.find(params[:user_id])
    @health_log = HealthLog.new
  end

  def create
    @health_log = HealthLog.new(health_log_params)
    @health_log.user_id = current_user.id
    if @health_log.save
      redirect_to user_health_log_path(@health_log.user, @health_log), notice: '今日の記録を保存しました！'
    else
      render :new
    end
  end

  def index
    # current_userのidに一致している全レコードを取得
    @health_logs = HealthLog.where(user_id: current_user.id).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:user_id])
    @health_log = HealthLog.find(params[:id])
  end

  def edit
    @user = User.find(params[:user_id])
    @health_log = HealthLog.find(params[:id])
  end

  def update
    @health_log = HealthLog.find(params[:id])
    @health_log.update(health_log_params)
    redirect_to user_health_log_path(@health_log.user, @health_log), notice: '記録内容を更新しました'
  end

  def graph
    # 今日から７日前をfromに格納　.weekをつけないとだめ
    from  = Time.current.at_beginning_of_day - 1.week
    # 今日をtoに格納
    to    = Time.current.at_end_of_day
    # pluckは指定されたものだけの配列を作る
    @weekly_weight = HealthLog.where(user_id: current_user.id, created_at: from...to).pluck(:health_log_on, :weight)

    # 今日から一ヶ月前を格納
    from2 = Time.current.at_beginning_of_day - 1.month
    # 今日を格納
    to2 = Time.current.at_end_of_day
    @monthly_weight = HealthLog.where(user_id: current_user.id, created_at: from2...to2).pluck(:health_log_on, :weight)

    # 一週間の体温
    from3 = Time.current.at_beginning_of_day - 1.week
    to3 = Time.current.at_end_of_day
    @weekly_temperature = HealthLog.where(user_id: current_user.id, created_at: from3...to3).pluck(:health_log_on, :temperature)

    # 一ヶ月の体温
    from4 = Time.current.at_beginning_of_day - 1.month
    to4 = Time.current.at_end_of_day
    @monthly_temperature = HealthLog.where(user_id: current_user.id, created_at: from4...to4).pluck(:health_log_on, :temperature)
  end

  def memo
    @health_logs = HealthLog.where(user_id: current_user.id).page(params[:page]).per(10).order(created_at: :desc)
  end

  def calendar
    @health_logs = HealthLog.where(user_id: current_user.id)
  end

  def search
    # viewのformで受け取ったパラメータをモデルに渡す
    # 78~80行目のコメントアウトはモデルの6~9行目の記述に変えたときに追記しないとエラーがでるという内容。
    # nilガードの&をorder page perのカンマの前に書く
    # unless params[:search]
    # @health_logs = current_user.health_logs.order(created_at: :desc)&.page(params[:page])&.per(10)
    # else
    @health_logs = HealthLog.search(current_user, params[:search]).order(created_at: :desc).page(params[:page]).per(10)
    # end
  end

  private

  def health_log_params
    params.require(:health_log).permit(:weight, :temperature, :feeling, :is_active, :memo, :exercise, :morning, :lunch, :dinner, :health_log_on, :start_time)
  end

  def ensure_correct_user
    @health_log = HealthLog.find(params[:id])
    unless @health_log.user == current_user
      redirect_to user_health_logs_path(current_user)
    end
  end
end
