class ApplicationsController < ApplicationController

  def list_applications
    begin
      @applications = Application.all.as_json(:except => :id)
    rescue Exception => exc
      return render json: { error => exc.message }, status: 500
    end
    render json: @applications, status: 200
  end

  def index
    begin
      app_id = decoded_token
      if app_id != nil
        @application = Application.find(id: app_id).as_json(:except => :id)
      else
        render json: { error: 'Invalid Token' }, status: 403
        return
      end
    rescue Exception => exc
      render json: { error => exc.message }, status: 500
      return
    end
    render json: @application, status: 200
  end

  def create
    @application = Application.create(application_params)
    if @application.valid?
      token = encode_token({ app_id: @application.id, app_name: @application.name })
      render json: { app_token: token }
    else
      render json: { error: "Invalid name" }
    end
  end

  def update
    begin
      app_id = decoded_token
      @application = Application.find_by(id: app_id)
      @application.update(application_params).as_json(:except => :id)
    rescue Exception => exc
      return render json: { error => exc.message }, status: 500
    end
    render json: @application, status: 200
  end

  private

  def application_params
    params.permit(:name)
  end
end
