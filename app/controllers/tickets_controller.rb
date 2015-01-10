class TicketsController < ApplicationController

  def new
    @ticket = Ticket.new
    @customer = @ticket.build_customer
  end

  def index
    @tickets = Ticket.all
  end

  def create
    @ticket = Ticket.new ticket_params
    if @ticket.save
      MessageNotifier.delay.notification()
      redirect_to root_path, flash: { notice: "New ticket request was created." }
    else
      render :new
    end
  end

  private

    def ticket_params
      params.require(:ticket).permit(:subject, :description, customer_attributes: [:first_name, :last_name, :email])
    end
end