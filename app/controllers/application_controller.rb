class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required

  def authenticate_user
    if logged_in?
      unless current_user.id == @task.user_id
        redirect_to tasks_path, notice:"権限を持っていません"
      end
    end
    else
      redirect_to new_user_path, notice:"ログインしてください"
    end
  end

  def ensure_current_user
    if logged_in?
      unless current_user.id == params[:id].to_i
        redirect_to tasks_path, notice:"権限を持っていません"
      end
    else
      redirect_to new_user_path, notice:"ログインしてください"
  end

  def logined_not_user_new
    redirect_to tasks_path, notice:"ユーザを新規作成する場合はログアウトしてください"
  end

  private
  def login_required
    redirect_to new_session_path unless current_user
  end
end
