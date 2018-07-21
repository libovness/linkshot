class ShotsController < ApplicationController
  before_action :set_shot, only: [:show, :edit, :update, :destroy]

  # GET /shots
  # GET /shots.json
  def index
    @shots = Shot.where(published: true, user: !nil).limit(10)
  end

  # GET /shots/1
  # GET /shots/1.json
  def show
    page_title = 'Linkshot: ' + @shot.name
    if @shot.user.nil?
      page_description = @shot.name + ' — Shared via Linkshot'
    else 
      page_description = @shot.name + ' — Shared by ' + @shot.user.name + ' via Linkshot'
    end
  end

  # GET /shots/new
  def new
    page_title = 'New Linkshot'
    page_description = 'Share a set of links'
    @shot = Shot.new
    2.times {@shot.links.build}
  end

  # GET /shots/1/edit
  def edit
  end

  # POST /shots
  # POST /shots.json
  def create
    @shot = Shot.new(shot_params)
    if current_user 
      @shot.user = current_user
    end
    respond_to do |format|
      if @shot.save
        if @shot.user.nil?
          cookies[:created] = @shot.id
          notice = '<em>One-time message:</em> If you want to save this shot in order to edit it later, you must <a href="/auth/twitter?origin=/shot/save/' + @shot.slug + '">Sign in with Twitter</a> now to claim it.'
        else 
          notice = ''
        end 
        format.html { redirect_to @shot, notice: notice }
        format.json { render :show, status: :created, location: @shot }
      else
        format.html { render :new }
        format.json { render json: @shot.errors, status: :unprocessable_entity }
      end
    end
  end

  def save
    @shot = set_shot
    if current_user 
      @shot.user = current_user
      @shot.save
    end
    redirect_to @shot
  end

  # PATCH/PUT /shots/1
  # PATCH/PUT /shots/1.json
  def update
    
    respond_to do |format|
      if @shot.update(shot_params)
        format.html { redirect_to @shot, notice: 'Shot was successfully updated.' }
        format.json { render :show, status: :ok, location: @shot }
      else
        format.html { render :edit }
        format.json { render json: @shot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shots/1
  # DELETE /shots/1.json
  def destroy
    @shot.destroy
    respond_to do |format|
      format.html { redirect_to shots_url, notice: 'Shot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shot
      @shot = Shot.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shot_params
      params.require(:shot).permit(:slug, :name, :user, :published, links_attributes: [:id, :title, :url, :_destroy])
    end
end
