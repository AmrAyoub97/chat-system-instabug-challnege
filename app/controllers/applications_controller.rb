class ApplicationsController < ApplicationController

  #GET   /applications/list --Return List Of All Applications
  def list_applications
    begin
      @applications = Application.all.as_json(:except => :id)
    rescue Exception => exc
      return render json: { error => exc.message }, status: 500
    end
    render json: @applications, status: 200
  end

  #GET   /applications --Return An Application {name, chats_count}
  def index
    begin
      application = decoded_token
      if application != nil
        app_chats_count = $redis.get(Application.CHAT_COUNT_REDIS_KEY(application[:app_name]))
        app_name = application[:app_name]
      else
        render json: { error: 'Invalid Token' }, status: 403
        return
      end
    rescue Exception => exc
      render json: { error => exc.message }, status: 500
      return
    end
    render json: { application: { name: app_name, chats_count: app_chats_count } }, status: 200
  end

  #POST   /applications --Create New Application {name}
  def create
    @application = Application.new(application_params)
    if @application.valid?
      Application.create(application_params)
      $redis.set(Application.CHAT_COUNT_REDIS_KEY(@application.name), 0)
      token = encode_token({ app_name: @application.name })
      render json: { app_token: token }
    else
      render json: { error: "Invalid name" }
    end
  end

  #PUT   /applications --Update Existing Application {name}
  def update
    begin
      application = decoded_token
      if application != nil
        change_redis_key_name(application[:app_name], application_params['name'])
        application = Application.find_by_id(application[:app_id])
        application.update(application_params)
        token = encode_token({ app_name: application_params['name'] })
      else
        render json: { error: 'Invalid Token' }, status: 403
        return
      end
    rescue Exception => exc
      return render json: { error => exc.message }, status: 500
    end
    render json: { app_token: token }, status: 200
  end

  private

  def change_redis_key_name(old_name, new_name)
    old_chat_count = $redis.get(Application.CHAT_COUNT_REDIS_KEY(old_name))
    $redis.del(Application.CHAT_COUNT_REDIS_KEY(old_name))
    $redis.set(Application.CHAT_COUNT_REDIS_KEY(new_name), old_chat_count)
  end

  def application_params
    params.require(:application).permit(:name)
  end
end
