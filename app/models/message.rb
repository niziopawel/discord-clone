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
  validates :body, presence: true

  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  belongs_to :channel
  scope :user_channel_messages, lambda { |user_id, channel_id|
                                  where(['author_id = ? and channel_id = ?', user_id, channel_id])
                                }
end
