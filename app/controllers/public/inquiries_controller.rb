class Public::InquiriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @inquery = Inquiry.new
    render :action => 'index'
  end

  def confirm
    #@inquiry = Inquiry.new(inquiry_params)
    #if @inquiry.save
     # render :action => 'confirm'
    #else
     # render :action => 'index'
    #end
    # 入力値のチェック
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      # OK。確認画面を表示
      render :action => 'confirm'
    #else
      # NG。入力画面を再表示
     # render :action => 'index'
    end
  end

  def thanks
    # メール送信
    @inquiry = Inquiry.new(params[:inquiry].permit(:title, :message, :user_id))
    InquiryMailer.received_email(@inquiry).deliver
    # 完了画面を表示
    render :action => 'thanks'
  end

  private

  def inquiry_params
    params.permit(:title, :message, :user_id)
  end

end
