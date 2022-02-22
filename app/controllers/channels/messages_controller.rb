# frozen_string_literal: true

module Channels
  class MessagesController < ApplicationController
    include ActionView::RecordIdentifier
    include RecordHelper
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
          message = Message.new
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(dom_id_for_records(@channel, message),
                                                      partial: 'messages/form',
                                                      locals: { channel: @channel,
                                                                message: message })
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
end
