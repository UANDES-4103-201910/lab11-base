class HomeController < ApplicationController
  def index
    @events = Event.where("start_date >= ?", DateTime.current())
  end
end
