class ChatsController < ApplicationController

  def show
    begin
      app_id = decoded_token
      if app_id != nil
        @chats = Chat.find(application_id: app_id, chat_number: params[:id]).as_json(:except => :id)
      else
        render json: { error: 'Invalid Token' }, status: 403
        return
      end
    rescue Exception => exc
      render json: { error => exc.message }, status: 500
      return
    end
    render json: @chats, status: 200
  end

  def index
    begin
      app_id = decoded_token
      if app_id != nil
        @chats = Chat.find(application_id: app_id).as_json(:except => :id)
      else
        render json: { error: 'Invalid Token' }, status: 403
        return
      end
    rescue Exception => exc
      render json: { error => exc.message }, status: 500
      return
    end
    render json: @chats, status: 200
  end

  def create
    begin
      app_id = decoded_token
      if app_id != nil
        @application = Application.find(application_id: app_id)
        @application.chats_count += 1
        chat_number = @application.chats_count
        Chat.create(chat_number:chat_number,application_id: app_id)
      else
        render json: { error: 'Invalid Token' }, status: 403
        return
      end
    rescue Exception => exc
      render json: { error => exc.message }, status: 500
      return
    end
    render json: { chat_number:chat_number }, status: 200  end
end
