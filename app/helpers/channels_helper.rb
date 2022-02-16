# frozen_string_literal: true

module ChannelsHelper
  def formatted_name(channel)
    "# #{channel.name}"
  end
end
