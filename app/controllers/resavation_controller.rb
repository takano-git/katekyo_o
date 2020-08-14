class ResavationController < ApplicationController
  # ParentがTutorのLessonを予約する画面
  def edit_oneday
    @resavation = Resavation.new
    @tutor = User.find(params[:id])
    @day = params[:day]
    @lessons = Lesson.where(user_id: @tutor.id).where("lesson_date LIKE?", @day)
    
    # resavation_hours = []
    # for resavation_hours in 0..23 do
    #   resavation_hours.push(0) 
    # end
    # @resavation_hours = resavation_hours
    @resavations = Resavation.where(tutor_id: @tutor.id).where(resavation_date: params[:day])
    
    resavation_hour_statuses = []
    
    @resavation_hour_statuses = ["◎","◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎", "◎"]
    # @lessons.each do |lesson|
      
    # start_date <= {対象終了日付} AND end_date >= {対象開始日付}
    # lesson.start <= 
    # end
  end
  #   24.times{|num|
  #     check_resavation_status(num)
  #   }
  # end

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
