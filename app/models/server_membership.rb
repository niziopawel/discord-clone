# == Schema Information
#
# Table name: server_memberships
#
#  id         :integer          not null, primary key
#  member_id  :integer          not null
#  server_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_server_memberships_on_member_id  (member_id)
#  index_server_memberships_on_server_id  (server_id)
#

class ServerMembership < ApplicationRecord
  belongs_to :user, foreign_key: :member_id
  belongs_to :server
end
