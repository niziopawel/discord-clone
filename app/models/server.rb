# == Schema Information
#
# Table name: servers
#
#  id         :integer          not null, primary key
#  name       :string
#  owner_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_servers_on_owner_id  (owner_id)
#

class Server < ApplicationRecord
  validates :name, presence: true

  belongs_to :owner, class_name: 'User'
  has_many :channels, dependent: :destroy
  has_many :server_memberships
  has_many :members, through: :server_memberships, source: :user
end
