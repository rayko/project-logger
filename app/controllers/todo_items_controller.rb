class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: %i[ flip destroy ]

  def flip
    @todo_item.flip!
    @project = @todo_item.project
    respond_to do |format|
      format.html { redirect_to @project }
      format.json { render :show, status: :created, location: @todo_item }
    end
  end
  
  # POST /todo_items or /todo_items.json
  def create
    @todo_item = TodoItem.new(todo_item_params)
    @project = @todo_item.project
    respond_to do |format|
      if @todo_item.save
        format.html { redirect_to @project, notice: "Todo item was successfully created." }
        format.json { render :show, status: :created, location: @todo_item }
      else
        format.html { redirect_to @project, alert: "Invalid" }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_items/1 or /todo_items/1.json
  def destroy
    @project = @todo_item.project
    @todo_item.destroy!

    respond_to do |format|
      format.html { redirect_to @project, notice: "Todo item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_item
      @todo_item = TodoItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_item_params
      params.require(:todo_item).permit(:project_id, :text, :checked)
    end
end
