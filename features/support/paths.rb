def path_to(page_name)
  case page_name
  when /welcome page/
    root_path
  when /the list of tickets/
    tickets_path
  when /new ticket/
    new_ticket_path
  # Add more page name => path mappings here
  else
    raise "Can't find mapping from \"#{page_name}\" to a path."
  end
end