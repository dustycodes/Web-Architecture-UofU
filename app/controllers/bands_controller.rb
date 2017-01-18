class BandsController < ApplicationController
  require 'html_helper'
  require 'users_helper'

  before_action :set_band, only: [:show, :edit, :update, :destroy]

  # GET /bands
  # GET /bands.json
  def index
    @bands = Band.all
  end

  # GET /bands/1
  # GET /bands/1.json
  def show
  end

  # GET /bands/new
  def new
    @band = Band.new
  end

  # GET /bands/1/edit
  def edit
  end

  # POST /bands
  # POST /bands.json
  def create
    createAlert = "<div class=\"alert alert-success alert-dismissable\"><strong>Band Created!</strong> You successfully added a band. <button type=\"button\" data-dismiss=\"alert\" class=\"close\"><span>&times;</span></button></div>"
    @band = Band.new(band_params)
    @band.venue_rating = 0
    @band.user_rating = 0
    @band.venue_rating_count = 0
    @band.user_rating_count = 0

    respond_to do |format|
      if @band.save
        format.html { redirect_to @band, notice: createAlert }
        format.json { render :show, status: :created, location: @band }
      else
        format.html { render :new }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bands/1
  # PATCH/PUT /bands/1.json
  def update
    updateAlert = "<div class=\"alert alert-success alert-dismissable\"><strong>Band Updated!</strong> You successfully updated a band. <button type=\"button\" data-dismiss=\"alert\" class=\"close\"><span>&times;</span></button></div>"
    respond_to do |format|
      if(band_params[:user_rating])
        @band.user_rating_count = @band.user_rating_count + 1
        @band.user_rating = (@band.user_rating * (@band.user_rating_count-1) + band_params[:user_rating].to_f)/@band.user_rating_count
        updateAlert = "<div class=\"alert alert-success alert-dismissable\"><strong>Thanks for the rating</strong><button type=\"button\" data-dismiss=\"alert\" class=\"close\"><span>&times;</span></button></div>"
        if @band.update :user_rating => @band.user_rating, :user_rating_count => @band.user_rating_count
          format.html { redirect_to @band, notice: updateAlert }
          format.json { render :show, status: :ok, location: @venue }
        else
          format.html { render :edit }
          format.json { render json: @band.errors, status: :unprocessable_entity }
        end
      elsif(band_params[:venue_rating])
        @band.venue_rating_count = @band.venue_rating_count + 1
        @band.venue_rating = (@band.venue_rating * (@band.venue_rating_count-1) + band_params[:venue_rating].to_f)/@band.venue_rating_count
        updateAlert = "<div class=\"alert alert-success alert-dismissable\"><strong>Thanks for the rating</strong><button type=\"button\" data-dismiss=\"alert\" class=\"close\"><span>&times;</span></button></div>"
        if @band.update :venue_rating => @band.venue_rating, :venue_rating_count => @band.venue_rating_count
          format.html { redirect_to @band, notice: updateAlert }
          format.json { render :show, status: :ok, location: @band }
        else
          format.html { render :edit }
          format.json { render json: @band.errors, status: :unprocessable_entity }
        end
      elsif current_user.id == @band.user_id
        if @band.update(band_params)
          format.html { redirect_to @band, notice: updateAlert }
          format.json { render :show, status: :ok, location: @band }
        else
          format.html { render :edit }
          format.json { render json: @band.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /bands/1
  # DELETE /bands/1.json
  def destroy
        if current_user.id == @band.user_id

    destroyAlert = "<div class=\"alert alert-success alert-dismissable\"><strong>Band Destroyed!</strong> You successfully destroyed a band. <button type=\"button\" data-dismiss=\"alert\" class=\"close\"><span>&times;</span></button></div>"
    @band.destroy
    respond_to do |format|
      format.html { redirect_to bands_url, notice: destroyAlert }
      format.json { head :no_content }
    end
    else
      updateAlert = "<div class=\"alert alert-danger alert-dismissable\"><strong>Failed to update:</strong> You don't own this band<button type=\"button\" data-dismiss=\"alert\" class=\"close\"><span>&times;</span></button></div>"
      format.html { redirect_to @band, notice: updateAlert  }
      format.json { render json: @band.errors, status: :unprocessable_entity }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_band
    @band = Band.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def band_params
    params.require(:band).permit(:venue_rating, :user_rating, :name, :selfie, :genre_id, :user_id)
  end
end
