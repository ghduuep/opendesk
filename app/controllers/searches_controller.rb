class SearchesController < ApplicationController
  layout :search_layout

  def show
    @query = params[:q].to_s.strip
    @results = Current.user.search(@query)
  end

  private

  def search_layout
    if Current.user.customer?
      "client"
    elsif Current.user.admin?
      "admin"
    else
      "agent"
    end
  end
end
