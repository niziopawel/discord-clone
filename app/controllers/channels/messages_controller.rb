class Channels::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  before_action :require_permission

  def new
    @message = Message.new
  end

  def create
    @channel = Channel.find(params[:channel_id])
    @message = @channel.messages.new(message_params)
    @message.author = current_user

    respond_to do |format|
      if @message.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('message_form', partial: 'messages/form',
                                                                    locals: { message: Message.new })
        end
      end
    end
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
