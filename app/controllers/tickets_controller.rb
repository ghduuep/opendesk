class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show edit update destroy]

  def index
    @tickets = Current.account.tickets
      .includes(:requester, :assignee)
      .search(params[:q])
      .with_status(params[:status])
      .with_priority(params[:priority])
      .assigned_to(params[:assigned_id])
      .recent
  end

  def show
    @messages = @ticket.messages.includes(:user).chronological
    @message = @ticket.messages.build
  end

  def new
    @ticket_form = TicketCreationForm.new(
      account: Current.account,
      attributes: ticket_form_defaults
    )
  end

  def create
    @ticket_form = TicketCreationForm.new(
      account: Current.account,
      attributes: ticket_creation_params
    )

    if @ticket_form.save
      redirect_to @ticket_form.ticket, notice: "Ticket created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    attributes = ticket_params

    @ticket.assign_attributes(ticket_params.except(:assignee_id))
    assign_assignee(attributes[:assignee_id]) if attributes.key?(:assignee_id)

    if @ticket.save
      respond_to do |format|
        format.html { redirect_to @ticket, notice: "Ticket updated. " }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :update, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ticket.destroy!

    redirect_to tickets_path, notice: "Ticket deleted."
  end

  private

  def ticket_form_defaults
    return {} unless params[:contact_id].present?

    contact = Current.account.contacts.find(params[:contact_id])

    {
      requester_name: contact.name,
      requester_email: contact.email
    }
  end

  def ticket_creation_params
    params.expect(
      ticket_creation_form: [
        :requester_name,
        :requester_email,
        :subject,
        :priority,
        :message_body
      ]
    )
  end

  def assign_assignee(assignee_id)
    @ticket.assignee =
      if assignee_id.blank?
        nil
      else
        Current.account.users.find(assignee_id)
      end
  end

  def set_ticket
    @ticket = Current.account.tickets.find(params[:id])
  end

  def ticket_params
    params.expect(
      ticket: [
        :subject,
        :status,
        :priority,
        :assignee_id
      ]
    )
  end
end
