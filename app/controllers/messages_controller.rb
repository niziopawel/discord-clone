class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[edit show]

  def index; end

  def new
    @message = Message.new
  end

  def create
    @channel = Channel.find(params[:channel_id])
    @message = @channel.messages.create!(message_params.merge(author_id: current_user.id))
  end

  def edit; end

  def update; end

  private

  def set_message
    Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
