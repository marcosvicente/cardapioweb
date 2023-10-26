class ApplicationController < ActionController::API
  attr_reader :current_user

  rescue_from CanCan::AccessDenied do |_e|
    forbidden_error!
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { error: exception.message }, status: :bad_request
  end

  def not_found
    render json: { error: 'not_found' }
  end
  
  def forbidden_error!
    render json: ['Você não tem autorização para acessar este recurso'], status: :forbidden
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  private
  def only_onwer_resource
    return true if current_user.try(:owner?)
    debugger
    forbidden_error!
  end

  def only_admin_resource
    return true if current_user.try(:admin?)
    forbidden_error!
  end
end
