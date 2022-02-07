# frozen_string_literal: true

class ChannelsController < ApplicationController
  before_action :set_channel, only: %i[show]
  before_action :set_server, only: %i[show new create]

  def show; end

  def create
    @channel = @server.channels.build(channel_params)

    respond_to do |format|
      if @channel.save
        redirect_to server_channel_path(@server, @channel), notice: 'Channel created successfully'
      else
        format.turbo_stream do
          render turbo_stream.update(
            'channel_form',
            partial: 'channels/form',
            locals: { server: @server, channel: @channel }
          )
        end
      end
    end
  end

  def edit; end

  def update; end

  private

  def channel_params
    params.require(:channel).permit(:name)
  end

  def set_channel
    @channel = Channel.find(params[:id])
  end

  def set_server
    @server = Server.find(params[:server_id])
  end
end
