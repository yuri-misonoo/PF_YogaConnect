class Public::HealthLogsController < ApplicationController
  before_action :authenticate_user!

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
  end

  def show
    @health_log = HealthLog.find(params[:id])
  end

  def edit
    @user = User.find(params[:user_id])
    @health_log = HealthLog.find(params[:id])
  end

  def update
    @health_log = HealthLog.find(params[:id])
    @health_log.update(health_log_params)
    redirect_to user_health_log_path(@health_log.user, @health_log), notice: '記録内容を保存しました'
  end

  def destroy
  end

  def graph
  end

  def memo
  end

  def calender
  end

  private

  def health_log_params
    params.require(:health_log).permit(:weight, :temperature, :feeling, :is_active, :memo, :exercise, :morning, :lunch, :dinner, :health_log_on)
  end

end
