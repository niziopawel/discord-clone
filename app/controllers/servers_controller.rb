class ServersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_server, only: %i[show]

  def index
    @servers = Server.all
  end

  def new; end

  def create
    @server = current_user.owned_servers.build(server_params)
    if @server.save
      redirect_to servers_path, notice: 'Server created successfully.'
    else
      render(turbo_stream:
        turbo_stream.update(
          'server_form',
          partial: 'servers/form',
          locals: { server: @server }
        ))
    end
  end

  def show; end

  private

  def server_params
    params.require(:server).permit(:name)
  end

  def set_server
    @server = Server.find(params[:id])
  end
end
