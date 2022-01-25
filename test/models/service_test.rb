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

require "test_helper"

class ServiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
