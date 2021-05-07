class StaticPagesController < ApplicationController
  def home
    @q = Room.ransack(params[:q])
  end
end
