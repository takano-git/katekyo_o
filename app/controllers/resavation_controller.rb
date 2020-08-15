class ResavationController < ApplicationController
  # ParentがTutorのLessonを予約するモーダル画面
  def edit_oneday
    @resavation = Resavation.new
    @tutor = User.find(params[:id])
    @day = params[:day]
    @lessons = Lesson.where(user_id: @tutor.id).where("lesson_date LIKE?", @day)
    
    @resavations = Resavation.where(tutor_id: @tutor.id).where(resavation_date: params[:day])
    # 予約が入っている時間を格納する予定の配列
    resavation_hours = []
    # resavation_hour_statuses = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    # レッスンが指定した日の２４時間で存在しているかを表す。　０：レッスン登録なし　１：登録なし
    lesson_exist = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    @lessons.each do |lesson|
      # 配列lesson_existのlesson.start.hour番目にステータス１（レッスン登録あり）に変える
      lesson_exist[lesson.start.hour..lesson.start.hour] = 1
      # resavation_hour_statuses[lesson.start.hour..lesson.start.hour] = lesson.status
      # Lesson_start_hours =lesson_start_hours.push(lesson.start.hour)
      # @resavation_hour_statuses = resavation_hour_statuses
      lesson_exist
    end
    
    # 指定した日の予約がすでに入っている時間を配列に入れる（配列resavationを返す）
    @resavations.each do |resavation|
      # @resavation_hour_statuses = resavation_hour_statuses.push(resavation.start.hour)
      resavation_hours =resavation_hours.push(resavation.start)
      resavation_hours
    end
    
    # @resavation_hour_statusesに予約のステータス２４時間分を詰めてviewに渡す　
    # ０：Lessonなし x　１：Lessonあり　予約あり　◎　２：lessonあり　予約あり　Full
    resavation_hours.each do |r|
      lesson_exist[r.hour..r.hour] = 2
      @resavation_hour_statuses = lesson_exist
      @resavation_hour_statuses
    end
  end


  def create
    # @resavation= Resavation.new(resavation_params)
    # if @resavation.save
    #   log_in @user # 保存成功後、ログインします。
    #   flash[:success] ='レッスンを予約しました。'
    #   redirect_to @user  #親のusers#showに飛ぶと思う
    # else
    #   render :edit_oneday
    # end
  end

  def update_oneday
    @user = current_user  # 親
    @tutor = User.find(params[:tutor_id])
    @resavations = Resavation.where(tutor_id: params[:tutor_id]).where(resavation_date: params[:day])
    selected_date = params[:resavation_date]
    selected_hour = params[:start]
    
    if selected_hour.length < 2
      selected_hour = "0" + selected_hour
    end
  
    start_string = selected_date + " " + selected_hour + ":00:00"
    finish_string = selected_date + " " + selected_hour + ":59:59"

    @resavation= Resavation.new(start: start_string, finish: finish_string, tutor_id: params[:tutor_id], user_id: params[:user_id], resavation_date: params[:resavation_date], status: 1)
 
    if @resavation.save
      log_in @user # 保存成功後、ログインします。
      flash[:success] ="家庭教師　#{@tutor.name}さんの家庭教師レッスンを#{@resavation.resavation_date}　#{@resavation.start.hour}時に予約しました。"
      redirect_to  controller: :users, action: :show, id: params[:tutor_id]  # tutorの個別ページに飛ぶ
    else
      render :edit_oneday
    end
  end


  private
    def resavation_params
      params.require(:resavation).permit(:start, :finish, :tutor_id, :status, :user_id, :resavation_date)
    end
end
