class LessonsController < ApplicationController
  def index
  end

  def create
  end
  
    def lessons_oneday
      @user = User.find(params[:id])
    end
end
