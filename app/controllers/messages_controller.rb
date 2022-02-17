# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[edit show update destroy]
  before_action :require_permission, only: %i[edit update destroy]

  def index; end

  def edit; end

  def update
    if @message.update(message_params)
      redirect_to @message.channel
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @message.destroy

    respond_to do |format|
      format.turbo_stream {}
      format.html { redirect_to @message.channel }
    end
  end

  private

  def require_permission
    return if @message.author == current_user

    redirect_to channel_path(@message.channel), status: :unauthorized
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
