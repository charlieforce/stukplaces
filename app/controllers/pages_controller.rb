class PagesController < ApplicationController
	before_action :authenticate_user!, only: [:dashboard, :jsonApi]
  
  def home
  	if current_user
  		redirect_to dashboard_path
  	end
  end

def dashboard
	@user = current_user
	@places = @user.places
	@reviews = @user.reviews

	respond_to do |format|
		format.html
		format.json { render json: @user }
	end

end

def jsonApi 

	@user = current_user
	@places = @user.places
	@reviews = @user.reviews

	render json: [@user, @reviews, @places]
	#render json: asdsad, status: 302
end

def jsonApiWithoutAuthenticate 

	@user = User.all
	@places = Place.all
	@reviews = Review.all

	render json: {jsonDate: [@user, @reviews, @places]}
	#render json: asdsad, status: 302
end

end
