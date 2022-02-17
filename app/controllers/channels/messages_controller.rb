class Channels::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  before_action :require_permission

  def new
    @message = Message.new
  end

  def create
    @channel = Channel.find(params[:channel_id])
    @message = @channel.messages.create!(message_params.merge(author_id: current_user.id))
  end

  private

  def require_permission
    return if @channel.server.server_member?(current_user)

    redirect_to channel_path(@message.channel), status: :unauthorized,
                                                notice: 'You have to be member of the server to send message'
  end

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
