class CalendarController < ApplicationController
  before_action :set_date
  def index

  end

  def week
  end


  def day
  end

  private 
  def set_date
    @date =  DateTime.now.strftime("%B %d %Y")
  end
end
