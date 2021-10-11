class UsersController < ApplicationController
# ログインしているユーザのみ閲覧可能
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user =User.new(user_params)

    if @user.save
# ユーザー登録と同時にログイン
      session[:user_id] = @user_id
      flash[:notice] ='ログインしました'
      redirect_to user_path(@user.id),notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end



  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to tasks_path, notice: '他人のページへアクセスはできません'
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password,
                                  :password_confirmation)
  end

end
