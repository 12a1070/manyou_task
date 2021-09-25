class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all.page(params[:page]).per(5)
# 並び替えでソートするボタンを押された場合は降順
    if params[:sort_expired]
      @tasks = @tasks.order(limit: "DESC")
    elsif params[:sort_priority]
      @tasks = @tasks.order(created_at: "DESC")
    else
      @tasks = @tasks.order(created_at: "DESC")
    end


      # パラメータにタイトルとステータスの両方があった場合
    if params[:search_name].present? && params[:search_status].present?
        @tasks =Task.search_name(params[:search_name]).search_status(params[:search_status]).page(params[:page]).per(5)
      #  パラメータにタイトルのみがあった場合
    elsif params[:status_name].present?
      @tasks =Task.search_name(params[:search_name]).page(params[:page]).per(5)
      # パラメータにステータスのみがあった場合
    elsif
      @tasks = Task.search_status(params[:search_status]).page(params[:page]).per(5)
    end
  end


#     if params[:search]
#       @tasks = @tasks.where('name LIKE ?', "%#{params[:search]}%")
#     end

#  ステータス検索の実装
#     if params[:status]
#       @tasks = @tasks.
#     end

#   もし渡されたパラメータがタイトルとステータス両方だったとき
#     if params[:name].present? && params[:status].present?
#       @tasks =Task.search_name(params[:name]).search_status(params[:status]).page(params[:page]).per(5)
#  elsif もし渡されたパラメータがタイトルのみだったとき
#     elsif params[:status].present?
#       @tasks =Task.search_name(params[:name]).page(params[:page]).per(5)
#  elsif もし渡されたパラメータがステータスのみだったとき
#     elsif params[:status].present?
#       @tasks = Task.search_status(params[:status]).page(params[:page]).per(5)
#     end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "タスクを追加しました" }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "タスクを更新しました" }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "タスクを消去しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :content, :limit, :created_at, :status)
    end
  end
end
