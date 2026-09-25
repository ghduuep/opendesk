class Client::TicketsController < Client::BaseController
  before_action :set_ticket, only: :show

  def index
    @tickets = Current.user.contact&.tickets&.search(params[:q]).recent || Ticket.none
  end

  def show
    @messages = @ticket.messages.visible_to_customer.chronological

    @message = @ticket.messages.new
  end

  def new
    @ticket_form = ClientTicketCreationForm.new(
      account: Current.account,
      contact: Current.user.contact
    )
  end

  def create
    @ticket_form = ClientTicketCreationForm.new(
      account: Current.account,
      contact: Current.user.contact,
      attributes: ticket_params
    )

    if @ticket_form.save
      redirect_to client_ticket_path(@ticket_form.ticket), notice: "Ticket created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def ticket_params
    params.require(:client_ticket_creation_form).permit(:subject, :message_body)
  end

  def customer_tickets
    Current.user.contact&.tickets || Ticket.none
  end

  def set_ticket
    @ticket = customer_tickets.find(params[:id])
  end
end
