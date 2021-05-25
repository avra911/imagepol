class Manage::DomainsController < ApplicationController
  before_action :set_domain, only: [:show, :edit, :update, :destroy]
  before_action :is_owner, only: [:edit, :update, :destroy]

  # GET /domains
  # GET /domains.json
  def index
    @domains = current_user.domains.page(params[:page])
  end

  # GET /domains/new
  def new
    @domain = Domain.new
  end

  # GET /domains/1/edit
  def edit
  end

  # POST /domains
  # POST /domains.json
  def create
    @domain = Domain.new(domain_params.merge(:user_id => current_user.id))
    @domain.verify!

    respond_to do |format|
      begin
        if @domain.verified == true && @domain.save
          format.html { redirect_to @domain, notice: 'Domain was successfully created.' }
          format.json { render :show, status: :created, location: @domain }
        else
          respond_error(format, @domain, "Domain verification failed!")
        end
      rescue Mongo::Error => e
        if e.message.include? 'E11000'
          respond_error(format, @domain, "Domain already exists!")
        else
          raise e
        end
      end
    end
  end

  # PATCH/PUT /domains/1
  # PATCH/PUT /domains/1.json
  def update
    @domain.name = domain_params[:name]
    @domain.verify!

    respond_to do |format|
      begin
        if @domain.verified == true && @domain.update(domain_params)
          format.html { redirect_to @domain, notice: 'Domain was successfully updated.' }
          format.json { render :show, status: :created, location: @domain }
        else
          respond_error(format, @domain, "Domain verification failed!", :edit)
        end
      rescue Mongo::Error => e
        if e.message.include? 'E11000'
          respond_error(format, @domain, "Domain already exists!", :edit)
        else
          raise e
        end
      end
    end
  end

  # DELETE /domains/1
  # DELETE /domains/1.json
  def destroy
    @domain.albums.each do |album|
      album.photos.destroy
    end
    @domain.destroy
    respond_to do |format|
      format.html { redirect_to domains_url, notice: 'Domain was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      @domain = Domain.find(params[:id])
    end

    def is_owner
      unless current_user == @domain.user
        redirect_to(@domain, notice: "You cannot edit this domain.") and return
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def domain_params
      params.require(:domain).permit(:name, :user_id)
    end

    def respond_error(format, domain, message, type = :new)
      flash.now[:alert] = message
      format.html { render type }
      format.json { render json: domain.errors, status: :unprocessable_entity }
    end
end
