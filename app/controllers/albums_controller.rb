class AlbumsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :unlock, :index]

  # GET /albums/index
  # GET /albums/index.json
  def index
    @albums = Album.all.page(params[:page])
    @domains = Domain.where(:id.in => @albums.distinct(:domain_id)).index_by(&:id)

    render 'manage/albums/index'
  end

  def home
    if user_signed_in?
      render 'albums/home'
    else
      render 'albums/home_guest'
    end
  end

  def unlock
    @album = Album.find(params[:id])
    session[:password] ||= {}
    session[:password][@album.id.to_s] = album_params['password']

    if (album_params['password'] == @album.password)
      redirect_to request.referer, notice: "Password was correct."
    else
      redirect_to request.referer, notice: "Invalid password."
    end
  end

  def show
    @album = Album.find(params[:id])
    redirect_to domain_album_path(domain_name: (@album.domain_id.nil? ? @album.id : @album.domain.name),
        id: @album.slug,
        suffix: @album.suffix.parameterize) and return
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def album_params
    params.permit(:password)
  end
end
