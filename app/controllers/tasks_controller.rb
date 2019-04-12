class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to task_path
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      name: params["task"]["name"],
      description: params["task"]["description"],
    )

    is_successful = task.save

    if is_successful
      redirect_to task_path(task.id)
    else
      head :not_found
    end
  end

  def edit
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
    end
  end

  def update
    @task = Task.find(params[:id])

    if @task.nil?
      redirect_to tasks_path
    else
      @task.update(
        :name => params[:task][:name],
        :description => params[:task][:description],
      )
      redirect_to task_path(@task.id)
    end
  end

  #   @article = Article.find(params[:id])
  #   @article.update(title: params[:title], description: params[:description])
  #   redirect_to article_path(@article)

  # def destroy
  #   task = Task.find_by(id: params[:id])

  #   if task.nil?
  #     head :not_found
  #   else
  #     task.destroy
  #     redirect_to tasks_path
  #   end
  # end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end
end
