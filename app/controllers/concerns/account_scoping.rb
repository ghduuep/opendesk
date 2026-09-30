module AccountScoping
  extend ActiveSupport::Concern

  included do
    before_action :set_current_account
  end

  private

  def set_current_account
    Current.account = Account.find_by!(subdomain: request.subdomain)
  end
end
