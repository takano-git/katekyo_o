class LessonsController < ApplicationController
  before_action :set_user, only: [:lessons_oneday, :update_oneday]

  def index
  end

  def create
  end

    # tuterがモーダルでLesson可能日を入力する編集画面
  def lessons_oneday
    # @user = User.find(params[:id])
    @day = params[:day]
    # すでにLesson可能時間を入れていたら、表示のために用意しておく
    date_param = @first_day.to_s.slice(0..6) 

    @lessons = Lesson.where(lesson_date: date_param)
    #  ユーザー（Tutor）にひもづくLessonインスタンスを生成して用意しとく
    @lesson = @user.lessons.new
  end

  #  tuterが入力したLesson可能時間を保存する
  def update_oneday
    # @user = User.find(params[:id])
    @lesson = @user.lessons.new(lesson_date: params[:day])
    if @lesson.update_attributes(lesson_params)
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      flash[:danger] = "Lesson可能時間の登録に失敗しました。やり直して下さい。"
      redirect_to user_url @user
    end
  end

  private
  
    def lesson_params
      params.require(:lesson).permit(:start, :finish, :user_id, :lesson_date)
    end
end
