class Public::NotificationController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end
  
end
