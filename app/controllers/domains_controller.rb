class DomainsController < ApplicationController
  before_action :set_domain, only: [:show]
  # skip_before_action :authenticate_user!, only: [:index, :show]

  # GET /domains
  # GET /domains.json
  def index
    @domains = Domain.all.page(params[:page])

    render 'manage/domains/index'
  end

  # GET /domains/1
  # GET /domains/1.json
  def show
    @albums = @domain.albums.page(params[:page])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      @domain = Domain.find(params[:id])
    end
end
