class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # paramsハッシュからユーザーを取得します。
  def set_user
    @user = User.find(params[:id])
  end

  # ログイン済みのユーザーか確認します。
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
    
  # アクセスしたユーザーが現在ログインしているユーザーか確認します。
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
    
  # システム管理者権限かどうか確認します。
  def admin_user
    redirect_to root_url unless current_user.admin?
  end
  
  # システム管理者権限でないことを確認します。
  def not_admin_user
    redirect_to root_url unless !current_user.admin?
  end

  # Tutorかどうか確認します。
  def tutor_user
    redirect_to root_url unless current_user.tutor?
  end
  
  # Parentかどうか確認します。
  def parent_user
    redirect_to root_url unless current_user.parent?
  end
end