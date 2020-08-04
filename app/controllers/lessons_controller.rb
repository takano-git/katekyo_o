class LessonsController < ApplicationController
  before_action :set_user, only: [:lessons_oneday]

  
  def index
  end

  def create
  end

    # tuterがモーダルでLesson可能日を入力する編集画面
  def lessons_oneday
    # @user = User.find(params[:id])
    @day = params[:day]
    
  end

  # tuterが入力したLesson可能時間を保存する
  def update_oneday
  end
end
