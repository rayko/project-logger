class ProjectsController < ApplicationController
  before_action :authorize_user!
  before_action :set_project, only: %i[ show edit update destroy details upload_file_asset create_file_asset destroy_file_asset download_file_asset]

  def download_file_asset
    file_asset = @project.file_assets.where(id: params[:file_asset_id]).take
    if file_asset
      blob = file_asset.blob
      send_data blob.download, filename: blob.filename.to_s, content_type: blob.content_type
    else
      redirect_to details_project_path(@project), alert: 'File asset not found'
      return
    end
  end

  def destroy_file_asset
    file_asset = @project.file_assets.where(id: params[:file_asset_id]).take
    if file_asset
      file_asset.destroy
      redirect_to details_project_path(@project), notice: 'File asset destroyed'
    else
      redirect_to details_project_path(@project), alert: 'File asset not found'
      return
    end
  end
  
  def upload_file_asset
  end

  def create_file_asset
    if params.dig(:project, :file_asset).blank?
      redirect_to details_project_path(@project)
      return
    end
    @project.file_assets.attach params[:project][:file_asset]
    redirect_to details_project_path(@project), notice: 'File asset created'
  end

  def details
  end

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show
    @entries = @project.entries.order('date DESC').page(params[:page])
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :description, :status, :locked, :locked_at, :file_asset)
    end
end
