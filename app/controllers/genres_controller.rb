class GenresController < ApplicationController
  before_action :set_genre, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:index, :show, :edit, :update, :destroy]

  # GET /genres
  # GET /genres.json
  def index
    @genres = Genre.all
  end

  # GET /genres/1
  # GET /genres/1.json
  def show
    @bands = Band.where(genre_id: @genre.id).find_each
    @users = User.where(genre_id: @genre.id).find_each
  end

  # GET /genres/new
  def new
    @genre = Genre.new
  end

  # POST /genres
  # POST /genres.json
  def create
    @genre = Genre.new(genre_params)

    respond_to do |format|
      if Genre.find_by(title: genre_params[:title]) == nil
      if @genre.save
        format.html { redirect_to @genre, notice: 'Genre was successfully created.' }
        format.json { render :show, status: :created, location: @genre }
      else
        format.html { render :new }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
      else
        updateAlert = "<div class=\"alert alert-danger alert-dismissable\"><strong>Failed to create genre:</strong> It already exists bro<button type=\"button\" data-dismiss=\"alert\" class=\"close\"><span>&times;</span></button></div>"
        format.html { redirect_to @genre, notice: updateAlert  }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genre
      @genre = Genre.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def genre_params
      params.require(:genre).permit(:title)
    end
end
