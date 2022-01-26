# frozen_string_literal: true

module ApplicationHelper
  def servers_for_sidebar
    current_user.owned_servers if user_signed_in?
  end
end
