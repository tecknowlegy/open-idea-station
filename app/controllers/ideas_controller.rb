class IdeasController < ApplicationController
  skip_before_action :authorize, only: %i[index show]
  before_action :set_idea, only: %i[show edit update destroy]

  def index
    @ideas = Idea.includes(:categories)
                 .where(is_archived: false)
                 .where.not(published_at: [nil, ''])
                 .order(published_at: :desc)
  end

  def viewed
    # define local variable as its not needed in the view
    idea = Idea.find(params[:idea_id])
    @views = idea.viewers
  end

  def show
    return if logged_in? && !@current_user.ideas.find_by(id: @idea.id).nil?

    Viewer.create!(
      idea_id: @idea.id,
      time_viewed: Time.now,
      viewer_ip: request.remote_ip
    )
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = @current_user.ideas.new(idea_params)
    respond_to do |format|
      if @idea.save
        if params[:commit] == 'Publish'
          @idea.update_attributes!('published_at', Time.now)
        end
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /ideas/1/edit
  def edit
    if @idea.user[:id] != @current_user[:id]
      flash[:warning] = 'You are not authorized to edit this idea'
      redirect_to @idea
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        if params[:commit] == 'Publish'
          puts idea_params
          @idea.update_attributes!(published_at: Time.now)
        end
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
  def destroy
    return if @idea.user[:id] != @current_user[:id]
    
    @idea.update_attributes!(is_archived: true)
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: "#{@idea.name} was archived" }
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
    params.require(:idea).permit(:name, :description, :url, :is_archived, :all_categories)
  end
end
