class EventsController < ApplicationController
  def create
    @event = Event.new(event_params)

    if @event.save
      head :ok
    else
      Rails.logger.error(@event.errors.full_messages)
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  private

  def event_params
    {
      app: params.dig(*%w[data app name]),
      name: params.dig(*%w[webhook_metadata event include]),
      payload: JSON.parse(request.body.read)
    }
  end
end
