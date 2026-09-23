class ClientTicketCreationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :subject, :string
  attribute :message_body, :string

  attr_reader :ticket

  validates :subject, presence: true
  validates :message_body, presence: true

  def initialize(account:, contact:, attributes: {})
    @account = account
    @contact = contact

    super(attributes)
  end

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      @ticket = @account.tickets.create!(
        requester: @contact,
        subject: subject,
        priority: :normal,
        status: :open
      )

      @ticket.messages.create!(
        body: message_body,
        kind: :reply,
        user: @contact.user
      )
    end

    true
  rescue ActiveRecord::RecordInvalid => error
    copy_errors_from(error.record)
    false
  end

  private

  def copy_errors_from(record)
    record.errors.full_messages.each do |message|
      errors.add(:base, message)
    end
  end
end
