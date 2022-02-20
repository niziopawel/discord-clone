# frozen_string_literal: true

class ChannelsController < ApplicationController
  include ChannelsHelper
  before_action :set_channel, only: %i[show update edit destroy]
  before_action :require_permission, only: %i[edit update destroy]

  def show
    @server = @channel.server
    @messages = @channel.messages.includes(:author).order(created_at: :asc)
  end

  def edit; end

  def update
    if @channel.update(channel_params)
      redirect_to channel_path(@channel), notice: 'Channel updated successfully.'
    else
      render(
        turbo_stream: turbo_stream.update('channel_form', partial: 'channels/form', locals: { channel: @channel }),
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
    return if @channel.server.owner == current_user

    redirect_to channel_path(@channel), status: :unauthorized
  end

  def channel_params
    params.require(:channel).permit(:name)
  end

  def set_channel
    @channel = Channel.find(params[:id])
  end
end
