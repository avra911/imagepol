class Manage::PhotosController < ApplicationController
  before_action :set_photo, only: [:update, :destroy]
  before_action :is_owner, only: [:edit, :update, :destroy]

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params.merge(:user_id => current_user.id))

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json {
          render json: {
            message: "success",
            imageUrl: @photo.upload.url(:medium),
            fileID: @photo.id.to_s
          }, status: :ok
        }
      else
        format.html { render :new }
        format.json {
          render json: { error: @photo.errors.full_messages.join(',')},
                 status: :unprocessable_entity
        }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    respond_to do |format|
      if @photo.destroy
        format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
        format.json { render json: { message: "File deleted from server" }}
      else
        format.html { redirect_to photos_url, notice: @photo.errors.full_messages.join(',') }
        format.json { render json: { message: @photo.errors.full_messages.join(',') } }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def is_owner
      unless current_user == @photo.user
        redirect_to(@photo, notice: "You cannot edit this photo.") and return
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:title, :filename, :description, :album_id, :upload)
    end
end
