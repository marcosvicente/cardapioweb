class OwnersController < ApplicationController
  before_action :set_owner, only: %i[ show update destroy ]

  # GET /owners
  def index
    @owners = Owner.order(:created_at).page(paginate_params[:page]).per(paginate_params[:per_page])

    render json: @owners
  end

  # GET /owners/1
  def show
    render json: @owner
  end

  # POST /owners
  def create
    # debugger
    @owner = Owner.new(owner_params)

    if @owner.save
      render json: @owner, status: :created, location: @owner
    else
      render json: @owner.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /owners/1
  def update
    if @owner.update(owner_params)
      render json: @owner
    else
      render json: @owner.errors, status: :unprocessable_entity
    end
  end

  # DELETE /owners/1
  def destroy
    @owner.destroy
  end

  private
    def set_owner
      @owner = Owner.find(params[:id])
    end

    def owner_params
      params.permit(
        :name,
        :email,
        :phone
      )
    end
    
    def paginate_params
      params.permit(
        :page, :per_page
      )
    end
end
