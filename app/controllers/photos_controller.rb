class PhotosController < ApplicationController
  def rate
    @photo = Photo.find(params[:id])
    if photo_params[:vote] == "true"
      @photo.rate_and_save 1, current_user
    else
      @photo.unrate_and_save current_user
    end

    session[:carousel] = @photo.id.to_s
    redirect_back(fallback_location: root_path, notice: 'Photo vote updated.')
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:vote)
    end
end
