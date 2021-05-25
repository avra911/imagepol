class Manage::AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :is_owner, only: [:edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:home, :view]

  # GET '/album/:domain/:id/:suffix(.:format)'
  def view
    @domain = Domain.where(name: params[:domain_name]).first
    @album = @domain ? @domain.albums.find(params[:id]) : Album.find(params[:id])

    # check url format and discard the rest
    if @album.suffix.parameterize != params[:suffix] \
       or (@domain and @domain.name != params[:domain_name]) \
       or (!@domain and @album.id.to_s != params[:domain_name])
      render :file => "#{Rails.root}/public/404",
             :layout => false, :status => :not_found and return
    end

    render ( @album.password.empty? or (session[:password] and \
              session[:password].key?(@album.id.to_s) \
              and session[:password][@album.id.to_s] == @album.password) ) ? :show : :show_password
  end

  # GET /albums/index
  # GET /albums/index.json
  def index
    @albums = current_user.albums.page(params[:page])
    @domains = Domain.where(:id.in => @albums.distinct(:domain_id)).index_by(&:id)
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params.merge(:user_id => current_user.id))

    respond_to do |format|
      if @album.save
        format.html { redirect_to edit_manage_album_path(@album), notice: 'album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to edit_manage_album_path(@album), notice: 'album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    respond_to do |format|
      if @album.photos.destroy and @album.destroy
        format.html { redirect_to manage_albums_url, notice: 'album was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    def is_owner
      unless current_user == @album.user
        redirect_to(@album, notice: "You cannot edit this album.") and return
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:domain_id, :name, :suffix, :password, :fb_comments, :fb_id)
    end
end
