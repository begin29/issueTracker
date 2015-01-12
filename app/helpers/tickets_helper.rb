module TicketsHelper

  def get_version_user version
    User.find(version.whodunnit).full_name rescue nil
  end

  def get_first_ticket_version ticket_versions
    create_verion = []
    count = ticket_versions.count
    ticket_versions.delete_if {|v| create_verion = v if v.event ==  'create'}
    count > 1 ? ticket_versions.first.reify : create_verion.item rescue nil
  end

  def get_stuff_name stuff_id
    User.find(stuff_id).full_name rescue nil
  end

  def check_if_active tab
    'active' if params[:action] == tab
  end

end