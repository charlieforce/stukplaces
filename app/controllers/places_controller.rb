class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :destroy, :update]
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @places = Place.search(params[:search])
    # respond_with(@places)
  end

  def show
#    respond_with(@place)
    @reviews = @place.reviews
    @review = Review.new #for create new Review
  end

  def new
    @place = Place.new
    respond_with(@place)
  end

  def edit
    authorize! :manage, @place
  end

  def create
    @place = current_user.places.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: "Place was successfully created" }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :manage, @place
    @place.update(place_params)
    respond_with(@place)
  end

  def destroy
    authorize! :manage, @place
    @place.destroy
    respond_with(@place)
  end

  private
    def set_place
      @place = Place.find(params[:id])
    end

    def place_params
      params.require(:place).permit(:name, :address, :description, :phone, :website)
    end
end
