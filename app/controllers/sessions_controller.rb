class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ログイン後にユーザーズインデックスにリダイレクトします。
      log_in user
      redirect_to users_url
    else
      # レンダリングが終わっているページでフラッシュメッセージを表示
      # render :new などのレンダーで使う。
      # redirect_to　などの時は新たにレンダリングされるので flash[:danger]でよい
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end
  
  def destroy
    log_out
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
end
