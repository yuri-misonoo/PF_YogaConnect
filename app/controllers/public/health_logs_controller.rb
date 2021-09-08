class Public::HealthLogsController < ApplicationController
  before_action :authenticate_user!

  def new
    @health_log = HealthLog.new
  end

  def create
    @health_log = HealthLog.new(health_log_params)
    @health_log.user_id = current_user.id
    if @health_log.save
      redirect_to user_health_log_path(@health_log), notice: '今日の記録を保存しました！'
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
  end

  def update
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
    params.require(:health_log).permit(:weight, :tempreture, :feeling, :memo, :exercise, :morning, :lunch, :dinner, :health_log_on)
  end

end
