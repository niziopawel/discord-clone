# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :owned_servers,
           foreign_key: :owner,
           class_name: 'Server',
           dependent: :destroy

  has_many :server_memberships,
           foreign_key: :member_id,
           dependent: :destroy

  has_many :membered_servers,
           through: :server_memberships,
           source: :server

  has_many :messages,
           foreign_key: :author,
           class_name: 'Message',
           dependent: :destroy
end
