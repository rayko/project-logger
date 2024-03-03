class EntriesController < ApplicationController
  before_action :authorize_user!
  before_action :set_entry, only: %i[ edit update destroy ]

  # GET /entries/new
  def new
    @entry = Entry.new
    @entry.date = Date.today.strftime('%Y-%m-%d')
    if params[:project_id].present?
      @project = Project.find(params[:project_id])
      @entry.project = @project
      @entry.status = @project.status
    end
  end

  # GET /entries/1/edit
  def edit
    @project = @entry.project
  end

  # POST /entries or /entries.json
  def create
    @entry = Entry.new(entry_params)
    @project = @entry.project
    respond_to do |format|
      if @entry.save
        format.html { redirect_to @project, notice: "Entry was successfully created." }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1 or /entries/1.json
  def update
    @project = @entry.project
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to project_url(@project), notice: "Entry was successfully updated." }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1 or /entries/1.json
  def destroy
    @project = @entry.project
    @entry.destroy!

    respond_to do |format|
      format.html { redirect_to @project, notice: "Entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_entry
    @entry = Entry.find(params[:id])
  end
    
  # Only allow a list of trusted parameters through.
  def entry_params
    params.require(:entry).permit(:project_id, :date, :body, :status, :hours)
  end
end
