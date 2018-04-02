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
    @tasks = Task.all.order(created_at: :asc).search(params[:search]).page(params[:page]).per(5)
    #@tasks = Task.search(params[:search])
    if params[:sort] == 'updated_at'
      @tasks = Task.order(updated_at: :desc).page(params[:page]).per(5)
    elsif params[:sort] == 'deadline'
      @tasks = Task.order(deadline: :asc).page(params[:page]).per(5)
    elsif params[:sort] == 'status'
      @tasks = Task.order(status: :asc).page(params[:page]).per(5)
    elsif params[:sort] == 'priority'
      @tasks = Task.order(priority: :desc).page(params[:page]).per(5)
    #else
    #  @tasks = Task.page(params[:page]).per(5)
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
