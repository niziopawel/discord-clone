class ServersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_server, only: %i[show]

  def new; end

  def create
    @server = current_user.owned_servers.build(server_params)

    if @server.save
      @general_channel = @server.channels.create!(name: 'general')
      @first_member = ServerMembership.create!(member_id: current_user.id, server_id: @server.id)

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
