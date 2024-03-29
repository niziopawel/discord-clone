# frozen_string_literal: true

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
  validates :name, presence: true, uniqueness: true

  belongs_to :owner, class_name: 'User'
  has_many :channels, dependent: :destroy
  has_many :server_memberships, dependent: :destroy
  has_many :members, through: :server_memberships, source: :user
  after_create :create_general_channel, :add_owner_to_server_members

  def general_channel
    channels.find { |channel| channel.name == 'general' }
  end

  def server_owner?(user)
    owner == user
  end

  def server_member?(user)
    members.include?(user)
  end

  def user_membership(user)
    server_memberships.find_by('member_id = ?', user.id)
  end

  def create_general_channel
    channels.create(name: 'general')
  end

  def add_owner_to_server_members
    server_memberships.create(member_id: owner_id)
  end
end
