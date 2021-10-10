class UsersController < ApplicationController
# ログインしているユーザのみ閲覧可能
  # before_action :user_check, only: [:show]
  # before_action :check_user_login,only: [:new]
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
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password,
                                  :password_confirmation)
  end



end
