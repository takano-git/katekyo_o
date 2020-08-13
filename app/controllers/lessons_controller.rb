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
    already_there_lessons = Lesson.where(lesson_date: params[:lesson][:lesson_date], user_id:params[:lesson][:user_id])

    comparison_start_data = "#{params[:lesson][:lesson_date]} #{params[:lesson][:start]}+0900".to_datetime
    comparison_finish_data = "#{params[:lesson][:lesson_date]} #{params[:lesson][:finish]}+0900".to_datetime
    
    # 新規作成用オブジェクト
    @lesson = @user.lessons.new(start: start_data, finish: finish_data, user_id: params[:lesson][:user_id], lesson_date: params[:lesson][:lesson_date],status: 1)

    already_there_lessons.each do |atl|
      # comparison_start_data < atl.finish
    # 比較開始日付 <= 対象終了日付 AND 比較終了日付 >= 対象開始日付
      # if comparison_start_data < atl.finish AND comparison_finish_data > atl.finish
      # if comparison_start_data < comparison_finish_data

      if comparison_start_data < atl.finish && comparison_finish_data > atl.start
       # 重複しているので保存せずに戻る
        flash[:danger] = "Lesson時間が重複しています。重複しない時間帯を入力してください。"
        redirect_to user_url @user  and return  # 家庭教師のusers#show
      end
    end
    
    
    if @lesson.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      flash[:danger] = "Lesson可能時間の登録に失敗しました。"
      redirect_to user_url @user   # 家庭教師のusers#show
    end
  end

  private
  
    def lesson_params
      params.require(:lesson).permit(:start, :finish, :user_id, :lesson_date)
    end
end
