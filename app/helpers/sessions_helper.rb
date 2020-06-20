module SessionsHelper
  
  # 引数に渡されたユーザーオブジェクトでログインします。
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # ログアウト
  # セッションと＠current＿userを破棄します
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  # 現在ログイン中のユーザーがいる場合インスタンス（オブジェクト)を返します。
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  # 現在ログイン中のユーザーが入ればtrue,そうでなければfalseを返します。
  def logged_in?
    !current_user.nil?
  end
  
end
