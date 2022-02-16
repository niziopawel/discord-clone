# frozen_string_literal: true

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
  validates :name, presence: true
  belongs_to :server
  has_many :messages, dependent: :destroy
end
