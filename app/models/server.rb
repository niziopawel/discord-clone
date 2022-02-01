# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  name       :string
#  owner_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_services_on_owner_id  (owner_id)
#

class Server < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  validates :name, presence: true
end
