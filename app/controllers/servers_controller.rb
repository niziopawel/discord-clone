# frozen_string_literal: true

class ServersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_server, only: %i[show edit update destroy]

  def new; end

  def create
    @server = current_user.owned_servers.build(server_params)

    if @server.save
      @general_channel = @server.channels.create!(name: 'general')
      @first_member = ServerMembership.create!(member_id: current_user.id, server_id: @server.id)

      redirect_to server_channel_path(@server, @general_channel), notice: 'Server created successfully.'
    else
      render(
        turbo_stream: turbo_stream.update(
          'server_form',
          partial: 'servers/form',
          locals: { server: @server }
        ),
        status: :unprocessable_entity
      )
    end
  end

  def edit; end

  def update
    if @server.update(server_params)
      redirect_to server_channel_path(@server, @server.general_channel), notice: 'Server updated successfully.'
    else
      render(
        turbo_stream: turbo_stream.update(
          'server_form',
          partial: 'servers/form',
          locals: { server: @server }
        )
      )
    end
  end

  def show
    @server_channels = @server.channels
  end

  def destroy
    @server.destroy

    respond_to do |format|
      format.turbo_stream { redirect_to servers_path, status: :see_other, notice: 'Server was successfully destroyed.' }
    end
  end

  private

  def server_params
    params.require(:server).permit(:name)
  end

  def set_server
    @server = Server.find(params[:id])
  end
end
