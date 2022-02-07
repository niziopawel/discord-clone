# frozen_string_literal: true

module ApplicationHelper
  def servers_with_general_channel
    return unless user_signed_in?

    current_user
      .membered_servers
      .includes(:channels)
      .where('channels.name = ?', 'general')
      .references('channels')
  end
end
