class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @events = policy_scope(Event.geocoded)
    @markers = @events.map do |event|
      @icon = event.event_type.icon
      @demo = event.demo
           {
     lat: event.latitude,
     lng: event.longitude,
     infoWindow: render_to_string(partial: "info_window", locals: { demo: @demo, event: event }),
     image_url: helpers.asset_url(@icon)
     }
    end
  end

  def new
  end

  def show
    @comments = Event.find(params[:id]).comments
    authorize @comments
  end
end
