# frozen_string_literal: true

class ChannelsController < ApplicationController
  include ChannelsHelper
  before_action :set_channel, only: %i[show update edit destroy]
  before_action :set_server, only: %i[new create]
  before_action :require_permission, only: %i[new create edit update destroy]

  def show
    @server = @channel.server
    @messages = @channel.messages
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

  def update
    if @channel.update(channel_params)
      redirect_to channel_path(@channel), notice: 'Channel updated successfully.'
    else
      render(
        turbo_stream: turbo_stream.update('channel_form', partial: 'channel/form', locals: { channel: @channel }),
        status: :unprocessable_entity
      )
    end
  end

  def destroy
    @server = @channel.server
    @channel.destroy

    respond_to do |format|
      format.turbo_stream do
        redirect_to channel_path(@server.general_channel), status: :see_other,
                                                           notice: 'Channel was successfully destroyed.'
      end
    end
  end

  private

  def require_permission
    if action_name == 'new' || action_name == 'create'
      return if @server.owner == current_user
    elsif @channel.server.owner == current_user
      return
    end

    redirect_to channel_path(@channel), status: :unauthorized, notice: 'You do not have permission to do that.'
  end

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
