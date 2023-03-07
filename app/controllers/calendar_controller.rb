class CalendarController < ApplicationController
  before_action :set_date

  def index
    @start_of_month = @date_obj.beginning_of_month
  end

  def week
  end


  def day
    @starting_hour = @date_obj.hour > 12 ? 12 : 0
  end

  private 
  def set_date
    @date_obj = DateTime.now
    @date =  @date_obj.strftime("%B %d %Y")
    @all_month = @date_obj.all_month
    @all_week = @date_obj.all_week
    @all_month = {}
    build_month @date_obj.beginning_of_month.all_week, 0
  end

  def build_month week_days, week
    @all_month[week] = []
    week_days.each do |day|
      @all_month[week].push(day)
      if day.end_of_month.beginning_of_day == day and week != 0
        break
      elsif day.end_of_week.beginning_of_day == day
        week += 1

        return build_month day.next_week.all_week, week
      end
    end
  end
end
