# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[edit show update]

  def index; end

  def new
    @message = Message.new
  end

  def create
    @channel = Channel.find(params[:channel_id])
    @message = @channel.messages.create!(message_params.merge(author_id: current_user.id))
  end

  def edit; end

  def update
    if @message.update(message_params)
      redirect_to @message.channel
    else
      render turbo_stream: :turbo_stream.replace(@post, partial: 'messages/form', locals: { post: @post })
    end
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
