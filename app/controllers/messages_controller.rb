class MessagesController < ApplicationController

  def show
    begin
      application = decoded_token
      if application != nil
        chat_number = params[:chat_id]
        chat_id = Chat.find_by(application_id: application[:app_id], chat_number: chat_number).id
        @message = Message.find_by(application_id: application[:app_id], chat_id: chat_id, message_number: params[:id])
                          .as_json(:except => :id)
      else
        render json: { error: 'Invalid Token' }, status: 403
        return
      end
    rescue Exception => exc
      render json: { error => exc.message }, status: 500
      return
    end
    render json: @message, status: 200
  end

  def index
    begin
      application = decoded_token
      if application != nil
        @chats = Chat.find_by(application_id: application[:app_id], chat_number: params[:chat_id]).messages.as_json(:except => :id)
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
      application = decoded_token
      if application != nil
        chat_number = params[:chat_id]
        chat_id = Chat.find_by(application_id: application[:app_id], chat_number: chat_number).id
        message_number = $redis.incr(Chat.MESSAGE_COUNT_REDIS_KEY(application[:app_name], chat_number))
        MessageWorker.perform_async(message_params['body'], message_number, chat_id, application[:app_id])
      else
        render json: { error: 'Invalid Token' }, status: 403
        return
      end
    rescue Exception => exc
      render json: { error => exc.message }, status: 500
      return
    end
    render json: { message_number: message_number }, status: 200
  end

  def search
    begin
      application = decoded_token
      if application != nil
        chat_number = request.query_parameters['chat_number']
        chat_id = Chat.find_by(application_id: application[:app_id], chat_number: chat_number).id
        query = request.query_parameters['query']
        search_results = Message.search(query)
      else
        render json: { error: 'Invalid Token' }, status: 403
        return
      end
    rescue Exception => exc
      render json: { error => exc.message }, status: 500
      return
    end
    render json: { results: search_results }, status: 200
  end

  private

  def message_params
    params.permit(:body)
  end

end
