# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[edit show update destroy]
  before_action :require_permission, only: %i[edit update destroy]

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

  def destroy
    @message.destroy
  end

  private

  def require_permission
    return if @message.author == current_user

    redirect_to channel_path(@message.channel), status: :unauthorized, notice: 'You do not have permission to do that'
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
