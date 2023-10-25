class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :set_user, only: %i[show destroy]

  # GET /users
  def index
    @users = User.order(:created_at).page(paginate_params[:page]).per(paginate_params[:per_page])
    
    render json: @users , status: :ok
  end

  # GET /users/{id}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{id}
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(
      :first_name,
      :last_name,
      :name,
      :username,
      :email,
      :password
    )
  end

  # TODO refactory
  def paginate_params
    params.permit(
      :page, :per_page
    )
  end
end
