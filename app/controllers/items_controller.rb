require 'json'

class ItemsController < ApplicationController
  @@orders = JSON.parse(File.read(File.join(Rails.root, 'db/orders.json')))

  def index
    (order_to_render = @@orders.find { |order| order['id'].to_s == params[:order_id] }) or not_found

    render json: order_to_render['items']
  end

  private

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end