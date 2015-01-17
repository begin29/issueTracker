module TicketsHelper

  def check_if_active tab
    'active' if params[:action] == tab
  end

end