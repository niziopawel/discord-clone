# frozen_string_literal: true

module Servers
  class ChannelsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_server

    def new
      @channel = Channel.new
      render '/channels/new', locals: { server: @server, channels: @channel }
    end

    def create
      @channel = @server.channels.build(channel_params)

      if @channel.save
        redirect_to channel_path(@channel), notice: 'Channel created successfully'
      else
        render(
          turbo_stream: turbo_stream.update(
            'channel_form',
            partial: 'channels/form',
            locals: { server: @server, channel: @channel }
          )
        )
      end
    end

    private

    def require_permission
      return if @server.owner == current_user

      redirect_to channel_path(@channel), status: :unauthorized, notice: 'You do not have permission to do that.'
    end

    def set_server
      @server = Server.find(params[:server_id])
    end

    def channel_params
      params.require(:channel).permit(:name)
    end
  end
end
