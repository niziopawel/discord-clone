class MessagesController < ApplicationController
  def index; end

  def new; end

  def create; end

  def edit; end

  def update; end

  private

  def message_params
    params.require(:message).permit(:author_id, :channel_id, :body)
  end
end
