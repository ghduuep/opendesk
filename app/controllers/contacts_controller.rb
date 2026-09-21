class ContactsController < ApplicationController
  before_action :set_contact, only: :show

  def index
    @contacts = Current.account.contacts.includes(:tickets).order(:name, :email)
  end

  def show
    @tickets = @contact.tickets.recent
  end

  private

  def set_contact
    @contact = Current.account.contacts.find(params[:id])
  end
end
