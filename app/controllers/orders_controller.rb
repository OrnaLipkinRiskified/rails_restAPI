require 'json'

class OrdersController < ApplicationController
  @@orders = JSON.parse(File.read(File.join(Rails.root, 'db/orders.json')))

  def index
    orders_to_render = @@orders.select do |order|
      (!params.key?(:decision) || order['decision'] == params[:decision]) &&
        (!params.key?(:createdAt) || order['created_at'].start_with?(params[:createdAt]))
    end

    render json: orders_to_render.map { |order| order.select { |k, _| %w[id created_at decision].include?(k) } }
  end

  def show
    (order_to_render = @@orders.find { |order| order['id'].to_s == params[:id] }) or not_found
    order_to_render['number_of_items'] = order_to_render['items'].length
    fields_to_render = %w[id created_at decision amount decision_reason number_of_items]

    render json: order_to_render.select { |k, _| fields_to_render.include?(k) }
  end

  def update
    puts 'decision was updated' if params.key?(:notify) && params[:notify].downcase == 'true'
    (order_to_update = @@orders.find { |order| order['id'].to_s == params[:id] }) or not_found
    body = JSON.parse request.raw_post
    order_to_update['decision'] = body['decision']
    File.open(File.join(Rails.root, 'db/orders.json'), 'w') { |f| f.write @@orders.to_json }
    nil # returns "no content"
  end

  private

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

end
