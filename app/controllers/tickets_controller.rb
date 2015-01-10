class TicketsController < ApplicationController

  def new
    @ticket = Ticket.new
  end

  def index
    @tickets = Ticket.all
  end
end