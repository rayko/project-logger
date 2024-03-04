class ResourceLinksController < ApplicationController
  before_action :set_resource_link, only: %i[ edit update destroy ]

  # GET /resource_links/new
  def new
    @resource_link = ResourceLink.new
    if params[:project_id]
      @project = Project.find(params[:project_id])
      @resource_link.project = @project
    end
  end

  # GET /resource_links/1/edit
  def edit
    @project = @resource_link.project
  end

  # POST /resource_links or /resource_links.json
  def create
    @resource_link = ResourceLink.new(resource_link_params)
    @project = @resource_link.project

    respond_to do |format|
      if @resource_link.save
        format.html { redirect_to details_project_path(@project), notice: "Resource link was successfully created." }
        format.json { render :show, status: :created, location: @resource_link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @resource_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resource_links/1 or /resource_links/1.json
  def update
    @project = @resource_link.project
    respond_to do |format|
      if @resource_link.update(resource_link_params)
        format.html { redirect_to details_project_path(@project), notice: "Resource link was successfully updated." }
        format.json { render :show, status: :ok, location: @resource_link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @resource_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resource_links/1 or /resource_links/1.json
  def destroy
    @project = @resource_link.project
    @resource_link.destroy!

    respond_to do |format|
      format.html { redirect_to details_project_path(@project), notice: "Resource link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource_link
      @resource_link = ResourceLink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def resource_link_params
      params.require(:resource_link).permit(:title, :link, :project_id)
    end
end
