class Agent::MessagesController < Agent::BaseController
  def create
    @ticket = Current.account.tickets.find(params[:ticket_id])

    @message = @ticket.messages.build(message_params)
    @message.user = Current.user

    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to agent_ticket_path(@ticket), notice: "Message added. " }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "new_message",
            partial: "agent/messages/form",
            locals: {
              ticket: @ticket,
              message: @message
            }
          ), status: :unprocessable_entity
        end

        format.html do
          @messages = @ticket.messages.includes(:user).chronological
          render "agent/tickets/show", status: :unprocessable_entity
        end
      end
    end
  end

  private

  def message_params
    params.expect(message: [ :body, :kind ])
  end
end
