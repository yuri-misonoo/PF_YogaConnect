class Public::InquiriesController < ApplicationController
  before_action :authenticate_user!

  def index
    render :action => 'index'
  end

  def confirm
    # 入力値のチェック
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      render :action => 'confirm'
    else
      flash.now[:alert] = 'タイトルと内容どちらもご記入ください'
      render :action => 'index'
    end
  end

  def thanks
    # メール送信
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.received_email(@inquiry).deliver
      # 完了画面を表示
      render :action => 'thanks'
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:title, :message, :user_id, :email, :name)
  end

end
