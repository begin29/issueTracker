class TicketsController < ApplicationController
  authorize_resource
  before_filter :load_ticket, only: [:update, :show, :update_status, :take_ownership]
  before_filter :load_tickets, only: [:waiting_for_responsed, :closed, :on_holded, :index]

  def new
    @ticket = Ticket.new
    @ticket.build_customer(guest: true)
  end

  def index; end

  def create
    @ticket = Ticket.new ticket_params
    if @ticket.save
      UserMailer.request_email(@ticket.customer_id, @ticket.id).deliver_now
      redirect_to root_path, flash: { notice: "New ticket request was created." }
    else
      render :new
    end
  end

  def update
    if @ticket.update_attributes ticket_params
      @ticket.waiting_for_response! if !current_user && @ticket.workflow_state != 'waiting_for_responsed'
      redirect_to ticket_path(@ticket), flash: { notice: "Ticket was updated." }
    else
      render :show
    end
  end

  def show
    @comments = @ticket.comments
    @user_id = current_user ? current_user.id : @ticket.customer.id
  end

  def on_holded; end

  def closed; end

  def waiting_for_responsed; end

  def update_status
    begin
      @ticket.send("#{params[:state]}!")
      redirect_to request.referer, notice: "Status changed to #{params[:state].humanize}"
    rescue
      redirect_to [:tickets], alert: I18n.t('ticket.errors.cant_update_status')
    end
  end

  def take_ownership
    @ticket.update_attributes(stuff_id: current_user.id)
    @ticket.on_hold! unless @ticket.on_holded?
    redirect_to request.referer, notice: "Owner changes to #{current_user.full_name}"
  end

  private

    def load_tickets
      action_name = params[:action] == 'index' ? 'opened' : params[:action]
      @tickets = Ticket.solr_search( include: [:customer, :stuff] ){
        fulltext params[:query] if params[:query].present?
        with :workflow_state, action_name
        paginate page: params[:page], per_page: params[:per_page]
      }.results
      render 'index'
    end

    def load_user
      @exist_user = User.find_by_email(params[:ticket][:customer_attributes][:email]) rescue nil
    end

    def load_ticket
      @ticket = Ticket.friendly.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:stuff_id, :subject, :description, customer_attributes: [:first_name, :last_name, :email, :guest], comments_attributes: [:message])
    end
end