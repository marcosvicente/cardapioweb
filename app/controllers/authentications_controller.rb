class AuthenticationsController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /auth/login
  def login
    user = get_users(params)
    if user && user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      time = Time.now + 24.hours.to_i
      render json: { 
        token: token,
        exp: time.strftime("%m-%d-%Y %H:%M"),
        email: user.email,
        username: user.username 
      }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :username, :password)
  end

  def get_users(params)
    user = User.find_by_email(params[:email])
    return user unless user.nil?

    User.find_by_username(params[:username])
  end
end
