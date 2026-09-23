class ContactsController < ApplicationController
  before_action :set_contact, only: %i[show destroy]

  def index
    @contacts = Current.account.contacts.includes(:tickets).order(:name, :email)
  end

  def show
    @tickets = @contact.tickets.recent
  end

  def destroy
    if @contact.destroy
      redirect_to contacts_path, notice: "Contact deleted"
    else
      redirect_to contact_path(@contact), alert: "The contact cant be deleted because they have tickets."
    end
  end

  private

  def set_contact
    @contact = Current.account.contacts.find(params[:id])
  end
end
