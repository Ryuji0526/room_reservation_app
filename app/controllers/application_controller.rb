class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_search

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインをしてください"
        redirect_to login_url
      end
    end

    def set_search
      @q = Room.ransack(params[:q])
    end
end
