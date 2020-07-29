class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end
  
  def show
  # @user = User.find(params[:id])

    @lessons = Lesson.where(user_id: @user.id)
    # カレンダー表示機能
    @first_day = Date.current.beginning_of_month
    @last_day = @first_day.end_of_month
    @one_month = [*@first_day..@last_day].to_a

    @day_of_the_week = @first_day.wday
    prev_month = @first_day.prev_month.all_month
    next_month = @first_day.next_month.all_month

    # @day_of_the_week > 1 ? (@one_month = @first_day.all_week.to_a.slice(0..(@day_of_the_week + 1)) + @one_month.to_a) : @one_month
    # 月曜日始まりなので日曜日をたす
    # @day_of_the_week > 1 ? (@one_month = (@first_day.all_week.to_a.slice(0..(@day_of_the_week - 1)).to_a + @one_month.to_a)) : @one_month
    # 前月の日を求める　月曜始まりを日曜始まりへ変更 そして１ヶ月たす
    # 
                                      # (@first_day.all_week.to_a.unshift(@first_day.all_week.to_a.slice(0).prev_day)).to_a + @one_month
    # @day_of_the_week > 1 ? @one_month = ((@first_day.all_week.to_a.unshift(@first_day.all_week.to_a.slice(0).prev_day)).to_a + @one_month) : @one_month
    # @day_of_the_week > 1 ? @one_month = ( (@first_day.all_week.to_a.unshift(@first_day.all_week.to_a.slice(0).prev_day)).to_a.slice(0..@day_of_the_week) + @one_month ) : @one_month
    @day_of_the_week > 1 ? @one_month = ( (@first_day.all_week.to_a.unshift(@first_day.all_week.to_a.slice(0).prev_day)).to_a.slice(0..(@day_of_the_week-1)) + @one_month ) : @one_month

  end
  
  def new
    @user = User.new # form_withに渡すユーザーオブジェクトを生成し、インスタンス変数に代入します。
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user # 保存成功後、ログインします。
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def info
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
