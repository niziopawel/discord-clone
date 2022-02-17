# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  author_id  :integer          not null
#  body       :text
#  channel_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_messages_on_author_id   (author_id)
#  index_messages_on_channel_id  (channel_id)
#

class Message < ApplicationRecord
  include ActionView::RecordIdentifier
  validates :body, presence: true

  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  belongs_to :channel

  scope :user_channel_messages, lambda { |user_id, channel_id|
                                  where(['author_id = ? and channel_id = ?', user_id, channel_id])
                                }

  after_create_commit do
    broadcast_append_to [channel, :messages], target: "#{dom_id(channel)}_messages", partial: 'messages/message'
  end

  after_update_commit do
    broadcast_replace_to self
  end

  after_destroy_commit do
    broadcast_remove_to self
  end
end
