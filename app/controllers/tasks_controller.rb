class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /tasks
  def index
    @tasks = Task.recent
    # Limit search query length to prevent UI issues and truncate if needed
    search_param = params[:search]&.slice(0, 100)
    @tasks = @tasks.search_by_title(search_param) if search_param.present?
    @tasks = @tasks.page(params[:page]).per(25)  # Paginate: 25 tasks per page
    @search_query = search_param
    @tasks_count = @tasks.total_count  # More efficient than .count for paginated results
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to @task, notice: "Task was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "Task was successfully deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :status)
    end

    # Handle RecordNotFound exceptions
    def record_not_found
      redirect_to tasks_path, alert: "Task not found."
    end
end

