class TasksController < ApplicationController
  before_action :auth_user,{only:[:new,:edit,:update,:destroy]}
  before_action :ensure_correct_user,{only:[:edit,:update,:destroy]}


  def ensure_correct_user
    @task = Task.find_by(id: params[:id])
    if @current_user.id != @task.user_id
      flash[:notice] = "You don't have authority"
      redirect_to("/")
    end
  end

  def index
    @task_page = Task.page(params[:page])
    @tasks = Task.all.order(updated_at: :desc)
    @tasks = Task.search(params[:search])
    if params[:sort] == 'updated_at'
      @tasks = Task.all.order(updated_at: :desc)
    elsif params[:sort] == 'deadline'
      @tasks = Task.all.order(deadline: :asc)
    elsif params[:sort] == 'status'
      @tasks = Task.all.order(status: :asc)
    elsif params[:sort] == 'priority'
      @tasks = Task.all.order(priority: :desc)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = @current_user.id
    if @task.save
      redirect_to tasks_path
    else
      render "new"
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render "edit"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end


  private
    def task_params
      params.require(:task).permit(:content, :deadline, :status, :priority, {:label_ids => []})
    end

end
