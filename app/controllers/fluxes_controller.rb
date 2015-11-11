class FluxesController < ApplicationController
  before_action :set_flux, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  skip_before_action :verify_authenticity_token, if: :json_request?

  # GET /fluxes
  # GET /fluxes.json
  def index
    @fluxes = Flux.paginate(page: params[:page])
    @flux = current_user.fluxes.build if logged_in?

    respond_to do |format|
      format.html do
        render 'index'
      end

      format.json do
        render json: @fluxes
      end
    end
  end

  # GET /fluxes/1
  # GET /fluxes/1.json
  def show
    @flux = Flux.find(params[:id])
  end

  # GET /fluxes/new
  def new
    @user = current_user
    @flux = @user.fluxes.new
  end

  # GET /fluxes/1/edit
  def edit
    @user = current_user
    @flux = Flux.find(params[:id])
  end

  # POST /fluxes
  # POST /fluxes.json
  def create
    @flux = current_user.fluxes.build flux_params

    if @flux.save
      flash[:success] = "Create flux successfully!"
      respond_to do |format|
        format.html do
          redirect_to fluxes_url
        end

        format.json do
          render json: {success: true}
        end
      end
    else
      respond_to do |format|
        format.html do
          render 'new'
        end

        format.json do
          render json: {error: true}
        end
      end
    end
  end

  # PATCH/PUT /fluxes/1
  # PATCH/PUT /fluxes/1.json
  def update
    if @flux.update(flux_params)
      flash[:success] = "Update flux successfully!"
      redirect_to @flux
    else
      flash[:error] = "Update flux unsuccessfully :("
      redirect_to fluxes_url
    end
  end

  # DELETE /fluxes/1
  # DELETE /fluxes/1.json
  def destroy
    if @flux.destroy
      flash[:success] = "Destroy flux successfully!"
    else
      flash[:error] = "Destroy flux unsuccessfully :("
    end

    redirect_to fluxes_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flux
      @flux = Flux.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flux_params
      params.require(:flux).permit(:motion, :content, :user_id, :picture)
    end

    def correct_user
      @flux = Flux.find(params[:id])
      redirect_to fluxes_url if @flux.user_id != current_user.id
    end

  protected

  def json_request?
    request.format.json?
  end

end
