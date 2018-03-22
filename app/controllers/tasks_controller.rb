class TasksController < ApplicationController

  def index
    @tasks = Task.search(params[:search])
    @tasks = Task.all.order(updated_at: :desc)
    if params[:sort] == 'updated_at'
      @tasks = Task.all.order(updated_at: :desc)
    elsif params[:sort] == 'deadline'
      @tasks = Task.all.order(deadline: :desc)
    elsif params[:sort] == 'status'
      @tasks = Task.all.order(status: :desc)
    elsif params[:sort] == 'priority'
      @tasks = Task.all.order(priority: :desc)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
      params.require(:task).permit(:content, :deadline, :status, :priority)
    end

end
