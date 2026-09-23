class Client::MessagesController < Client::BaseController
  def create
    @ticket = customer_tickets.find(params[:ticket_id])

    @message = @ticket.messages.new(message_params)
    @message.user = Current.user
    @message.kind = :reply

    if @message.save
      redirect_to client_ticket_path(@ticket), notice: "Ticket created successfully"
    else
      @messages = @ticket.messages.visible_to_customer.chronological

      render "client/tickets/show", status: :unprocessable_entity
    end
  end

  private

  def customer_tickets
    Current.user.contact.tickets
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
