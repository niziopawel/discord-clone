# frozen_string_literal: true

class ChannelsController < ApplicationController
  include ChannelsHelper
  before_action :set_channel, only: %i[show update edit destroy]
  before_action :set_server, only: %i[new create]
  before_action -> { @server.server_owner?(current_user) }, only: %i[create update destroy]

  def show
    @server = @channel.server
  end

  def new
    @server = Server.find(params[:server_id])
    @channel = Channel.new
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

  def edit; end

  def update; end

  def destroy; end

  private

  def set_server
    @server = Server.find(params[:server_id])
  end

  def channel_params
    params.require(:channel).permit(:name)
  end

  def set_channel
    @channel = Channel.find(params[:id])
  end
end
