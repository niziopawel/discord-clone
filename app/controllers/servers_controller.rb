class ServersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_server, only: %i[show]

  def index
    @servers = Server.all
  end

  def new
    @server = Server.new
  end

  def create; end

  def show; end

  private

  def set_server
    @server = Server.find(params[:id])
  end
end
