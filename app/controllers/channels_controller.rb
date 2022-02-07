class ChannelsController < ApplicationController
  before_action :set_channel, only: %i[show]
  before_action :set_server, only: %i[show]

  def show; end

  def create; end

  def edit; end

  def update; end

  private

  def set_channel
    @channel = Channel.find(params[:id])
  end

  def set_server
    @server = Server.find(params[:server_id])
  end
end
