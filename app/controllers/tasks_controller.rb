class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :user_check_t, only: %i[:edit, :update, :destroy]

  # GET /tasks or /tasks.json
  def index
    # @tasks = Task.all
# N+1をincludesで解決
      @tasks = current_user.tasks.all.includes(:user).order

# 並び替えでソートするボタンを押された場合は降順
    if params[:sort_expired]
      @tasks = @tasks.order(limit: "ASC")
    elsif params[:sort_priority]
# 優先順位が低いソート
      @tasks = @tasks.order(priority: "ASC")
    end


        # パラメータにタイトルとステータスの両方があった場合
    if params[:search_name].present? && params[:search_status].present?
      @tasks =Task.search_name(params[:search_name]).search_status(params[:search_status])
      #  パラメータにタイトルのみがあった場合
    elsif params[:search_name].present?
      @tasks =Task.search_name(params[:search_name])
      # パラメータにステータスのみがあった場合
    elsif params[:search_status].present?
      @tasks = Task.search_status(params[:search_status])
      # それ以外の時
    else
      @tasks = @tasks.order(created_at: "DESC")
    end
    @tasks = @tasks.page(params[:page]).per(5)
  end


  # GET /tasks/1 or /tasks/1.json
  def show
    @task = Task.find(params[:id])
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks or /tasks.json
  def create
    # @task = Task.new(task_params)
    # # ログインシステムのテキスト・・・ログインしているユーザーのみの機能
    # @task.user_id = current_user.id

    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "タスクを追加しました" }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
    # render :new if @task.invalid?
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
      params.require(:task).permit(:name, :content, :limit, :created_at, :status, :priority)
    end
end
