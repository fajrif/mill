class EventsController < ApplicationController

  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show
		@event = Event.friendly.find(params[:id])
		# Other Events
    @events = Event.most_recent_events(@event.id, 2)
  end

end
