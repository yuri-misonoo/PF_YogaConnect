class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(20)

    #days = (Date.today.beginning_of_month..Date.today).to_a
    #後々、usersとtransposeする予定なので、rangeではなく、arrayに変更

    #@new_users = days.map { |user| User.where(:created_at => user.beginning_of_day..user.end_of_day).count }
    #mapでそれぞれの日にちに登録されたユーザー数をカウント
    #ここでも、active_supportのbeginning_of_dayとend_of_dayを利用
    #from = Time.current.at_beginning_of_day - 1.month
    #to = Time.current.at_end_of_day
    @new_users = User.where(created_at: Time.current.at_beginning_of_day...Time.current.at_end_of_day).size

  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'ユーザー情報を編集しました'
    end
  end

  private

  def user_params
    params.require(:user).permit(:is_deleted)
  end

end
