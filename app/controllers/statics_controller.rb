class StaticsController < ApplicationController

  def home
    if current_user
      redirect_to tickets_path
    end
  end
end