class HomeController < ApplicationController

  def home
    if current_user
      redirect_to tickets_path
    else
      @user = User.new_guest
    end
  end
end