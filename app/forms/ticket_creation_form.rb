class TicketCreationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :requester_name, :string
  attribute :requester_email, :string
  attribute :subject, :string
  attribute :priority, :string, default: "normal"
  attribute :message_body, :string

  attr_reader :ticket

  validates :requester_email, presence: true
  validates :subject, presence: true
  validates :message_body, presence: true

  def initialize(account:, attributes: {})
    @account = account
    super(attributes)
  end

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      contact = find_or_create_contact!

      @ticket = @account.tickets.create!(
        requester: contact,
        subject: subject,
        priority: priority,
        status: :open
      )

      @ticket.messages.create!(
        body: message_body,
        kind: :reply
      )
    end

    true
  rescue ActiveRecord::RecordInvalid => error
    copy_errors_from(error.record)
    false
  end

  private

  def find_or_create_contact!
    email = requester_email.strip.downcase

    contact = @account.contacts.find_or_initialize_by(email: email)

    if requester_name.present?
      contact.name = requester_name
    end

    contact.save!
    contact
  end

  def copy_errors_from(record)
    record.errors.full_messages.each do |message|
      errors.add(:base, message)
    end
  end
end
