class OrderSerializer
  include JSONAPI::Serializer
  attributes :id, :created_at, :email, :first_name, :city, :country, :browser_ip, :currency, :digital, :decision, :decision_reason, :amount, :items
end
