# == Schema Information
#
# Table name: channels
#
#  id         :integer          not null, primary key
#  name       :string
#  server_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_channels_on_server_id  (server_id)
#

class Channel < ApplicationRecord
  belongs_to :server

  def formatted_name
    "# #{name}"
  end
end
