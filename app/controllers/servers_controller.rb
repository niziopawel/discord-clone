class ServersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_server, only: %i[show]

  def index
    @servers = Server.all
  end

  def new; end

  def create
    @server = current_user.owned_servers.build(server_params)
    @general_channel = @server.channels.new(name: 'general')
    @first_member = ServerMembership.new(member_id: current_user.id, server_id: @server.id)

    if @server.save && @generaL_channel.save && @first_member.save
      redirect_to server_path(@server), notice: 'Server created successfully.'
    else
      render(turbo_stream:
        turbo_stream.update(
          'server_form',
          partial: 'servers/form',
          locals: { server: @server }
        ))
    end
  end

  def show
    @server_channels = @server.channels
  end

  private

  def server_params
    params.require(:server).permit(:name)
  end

  def set_server
    @server = Server.find(params[:id])
  end
end
