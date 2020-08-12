class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit_basic_info]

  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
  # @user = User.find(params[:id])
    @lessons = Lesson.where(user_id: @user.id)
    # カレンダー表示機能
    @first_day = params[:date].nil? ? Date.current.beginning_of_month : params[:date].to_date
    # @first_day = Date.current.beginning_of_month
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day].to_a

    @day_of_the_week = @first_day.wday
    prev_month = @first_day.prev_month.all_month
    next_month = @first_day.next_month.all_month

    # 月曜日始まりなので日曜日をたす
    # 前月の日を求める　月曜始まりを日曜始まりへ変更 そして１ヶ月たす
    # 月初が日曜日だったらone_monthに前月の日数を入れる
    @day_of_the_week > 1 ? one_month = ( (@first_day.all_week.to_a.unshift(@first_day.all_week.to_a.slice(0).prev_day)).to_a.slice(0..(@day_of_the_week-1)) + one_month ) : one_month
    # @one_monthに来月の日にちをたす
    @one_month = one_month.to_a + next_month.to_a.slice(0..(42 - one_month.count - 1))
    
    # すでにLesson可能時間を入れていたら、表示のためにLessonインスタンスたちを用意
    # date_param = @first_day.to_s.slice(0..6) 
    
    # @lessons = Lesson.where("lesson_date LIKE?", "%2020-08%") 注意！！herokuでエラーになり、cloud9ではエラーにならない間違った書き方
    search_date =  @first_day
    @lessons = Lesson.where(lesson_date: search_date.in_time_zone.all_month)
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
  
  def edit_basic_info
  end

  # def lessons_oneday
  #   @user = User.find(params[:id])
  # end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
