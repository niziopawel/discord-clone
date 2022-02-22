# frozen_string_literal: true

class ServersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_server, only: %i[show edit update destroy join leave]
  before_action :require_permission, only: %i[edit update destroy]

  def index
    @servers = Server.all.includes(:members)
                     .sort_by { |server| -server.members.count }
                     .filter { |server| current_user.owned_servers.exclude? server }
  end

  def new; end

  def create
    @server = current_user.owned_servers.build(server_params)

    if @server.save
      redirect_to channel_path(@server.general_channel), notice: 'Server created successfully.'
    else
      render(
        turbo_stream: turbo_stream.update('server_form', partial: 'servers/form', locals: { server: @server }),
        status: :unprocessable_entity
      )
    end
  end

  def edit; end

  def update
    if @server.update(server_params)
      redirect_to channel_path(@server.general_channel), notice: 'Server updated successfully.'
    else
      render(
        turbo_stream: turbo_stream.update('server_form', partial: 'servers/form', locals: { server: @server }),
        status: :unprocessable_entity
      )
    end
  end

  def show
    @server_channels = @server.channels
  end

  def destroy
    @server.destroy

    respond_to do |format|
      format.turbo_stream do
        redirect_to authenticated_root_path, status: :see_other, notice: 'Server was successfully destroyed.'
      end
    end
  end

  def join
    if @server.server_memberships.create(member_id: current_user.id)
      redirect_to @server.general_channel,
                  notice: 'You successfully join this server.'
    end
  end

  def leave
    @user_membership = @server.user_membership(current_user)

    redirect_to authenticated_root_path, notice: 'You successfully left this server.' if @user_membership.destroy
  end

  private

  def require_permission
    return if current_user == @server.owner

    redirect_to authenticated_root_path, status: :unauthorized
  end

  def server_params
    params.require(:server).permit(:name)
  end

  def set_server
    @server = Server.find(params[:id])
  end
end
