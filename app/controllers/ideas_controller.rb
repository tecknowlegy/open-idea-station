class IdeasController < ApplicationController
  skip_before_action :authorize, only: :index
  before_action :set_idea, only: %i[show edit update archive]

  # Get data on viewed ideas
  def viewed
    # define local variable as its not needed in the view
    ideas = Idea.find(params[:idea_id])
    @views = ideas.viewers
  end

  # Load ideas with its associated attributes
  def index
    @ideas = Idea.includes(:viewers, :comments, :categories)
                 .where(is_archived: false)
  end

  def show
    if @current_user.ideas.find_by(id: @idea.id).nil?
      Viewer.create!(
        idea_id: @idea.id,
        time_viewed: Time.now,
        viewer_ip: request.remote_ip
      )
    end
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = @current_user.ideas.new(idea_params)
    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /ideas/1/edit
  def edit; end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def archive
    @idea.update(is_archived: true)
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: 'Idea was archived.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_idea
    @idea = Idea.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list
  def idea_params
    params.require(:idea).permit(:name, :description, :url)
  end
end
