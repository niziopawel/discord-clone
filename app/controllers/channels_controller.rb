class ChannelsController < ApplicationController
  before_action :set_channel, only: %i[show]

  def show; end

  def create; end

  def edit; end

  def update; end

  private

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end
end
