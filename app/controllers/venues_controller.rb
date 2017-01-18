class VenuesController < ApplicationController
  require 'html_helper'

  before_action :set_venue, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:index, :show, :edit, :update, :destroy]

  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.all
    @venues_near_me = Venue.where(location: current_user.location).find_each
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  # POST /venues.json
  def create
    createAlert = "<div class=\"alert alert-success alert-dismissable\"><strong>Created a Venue!</strong> You successfully added a venue. <button type=\"button\" data-dismiss=\"alert\" class=\"close\"><span>&times;</span></button></div>"
    @venue = Venue.new(venue_params)
    @venue.prices = 0
    @venue.rating = 0
    @venue.ratings_count = 0
    @venue.price_ratings_count = 0

    respond_to do |format|
      if @venue.save
        format.html { redirect_to @venue, notice: createAlert }
        format.json { render :show, status: :created, location: @venue }
      else
        format.html { render :new }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    respond_to do |format|

      if(venue_params[:rating])
        @venue.ratings_count = @venue.ratings_count + 1
        @venue.rating = (@venue.rating * (@venue.ratings_count-1) + venue_params[:rating].to_f)/@venue.ratings_count
        updateAlert = "<div class=\"alert alert-success alert-dismissable\"><strong>Thanks for the rating</strong><button type=\"button\" data-dismiss=\"alert\" class=\"close\"><span>&times;</span></button></div>"
        if @venue.update :rating => @venue.rating, :ratings_count => @venue.ratings_count
          format.html { redirect_to @venue, notice: updateAlert }
          format.json { render :show, status: :ok, location: @venue }
        else
          format.html { render :edit }
          format.json { render json: @venue.errors, status: :unprocessable_entity }
        end
      elsif(venue_params[:prices])
        @venue.price_ratings_count = @venue.price_ratings_count + 1
        @venue.prices = (@venue.prices * (@venue.price_ratings_count-1) + venue_params[:prices].to_f)/@venue.price_ratings_count
        updateAlert = "<div class=\"alert alert-success alert-dismissable\"><strong>Thanks for the rating</strong><button type=\"button\" data-dismiss=\"alert\" class=\"close\"><span>&times;</span></button></div>"
        if @venue.update :prices => @venue.prices, :price_ratings_count => @venue.price_ratings_count
          format.html { redirect_to @venue, notice: updateAlert }
          format.json { render :show, status: :ok, location: @venue }
        else
          format.html { render :edit }
          format.json { render json: @venue.errors, status: :unprocessable_entity }
        end
      elsif current_user.id == @venue.user_id
        if @venue.update(venue_params)
          updateAlert = "<div class=\"alert alert-success alert-dismissable\"><strong>You successfully updated your venue</strong><button type=\"button\" data-dismiss=\"alert\" class=\"close\"><span>&times;</span></button></div>"
          format.html { redirect_to @venue, notice: updateAlert }
          format.json { render :show, status: :ok, location: @venue }
        else
          format.html { render :edit }
          format.json { render json: @venue.errors, status: :unprocessable_entity }
        end
      else
        updateAlert = "<div class=\"alert alert-danger alert-dismissable\"><strong>Failed to update:</strong> You don't own this venue<button type=\"button\" data-dismiss=\"alert\" class=\"close\"><span>&times;</span></button></div>"
        format.html { redirect_to @venue, notice: updateAlert  }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end

    end
  end

  def rate

  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    if current_user.id == @venue.user_id

      destroyAlert = "<div class=\"alert alert-success alert-dismissable\"><strong>Removed Venue!</strong> You successfully removed a venue. <button type=\"button\" data-dismiss=\"alert\" class=\"close\"><span>&times;</span></button></div>"
      @venue.destroy
      respond_to do |format|
        format.html { redirect_to venues_url, notice: destroyAlert }
        format.json { head :no_content }
      end
    else
      updateAlert = "<div class=\"alert alert-danger alert-dismissable\"><strong>Failed to update:</strong> You don't own this venue<button type=\"button\" data-dismiss=\"alert\" class=\"close\"><span>&times;</span></button></div>"
      format.html { redirect_to @venue, notice: updateAlert  }
      format.json { render json: @venue.errors, status: :unprocessable_entity }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_venue
    @venue = Venue.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def venue_params
    params.require(:venue).permit(:location, :selfie, :name, :age_required, :prices, :rating, :user_id)
  end
end
