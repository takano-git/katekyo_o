class LessonsController < ApplicationController
  before_action :set_user, only: [:lessons_oneday, :update_oneday]

  def index
  end

  def create
  end

    # tuterがモーダルでLesson可能日を入力するモーダルの編集画面
  def lessons_oneday
    # @user = User.find(params[:id])
    @day = params[:day]
    # すでにLesson可能時間を入れていたら、表示のために用意しておく
    # date_param = @first_day.to_s.slice(0..6) 

    # @lessons = Lesson.where(lesson_date: date_param)
    #  ユーザー（Tutor）にひもづくLessonインスタンスを生成して用意しとく
    @lesson = @user.lessons.new
  end

  #  tuterがモーダル入力したLesson可能時間を保存する
  def update_oneday
    # @user = User.find(params[:id]) ここではtutorのこと
    
    # すでに登録されているLessonを取得
    start_data = "#{params[:lesson][:lesson_date]} #{params[:lesson][:start]}"
    finish_data = "#{params[:lesson][:lesson_date]} #{params[:lesson][:finish]}"
    already_there_lessons = Lesson.where(lesson_date: params[:date])
    # already_there_lessons.each do |atl|
    # 比較開始日付 <= 対象終了日付 AND 比較終了日付 >= 対象開始日付
        # (params[:lesson][:start]).to_datetime <= alt.finish AND (params[:lesson][:finish]).to_datetime  >= alt.finish
    # end
    
    
    @lesson = @user.lessons.new(start: start_data, finish: finish_data, user_id: params[:lesson][:user_id], lesson_date: params[:lesson][:lesson_date],status: 1)
    if @lesson.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      flash[:danger] = "Lesson可能時間の登録に失敗しました。やり直して下さい。"
      redirect_to user_url @user   # 家庭教師のusers#show
    end
  end

  private
  
    def lesson_params
      params.require(:lesson).permit(:start, :finish, :user_id, :lesson_date)
    end
end
