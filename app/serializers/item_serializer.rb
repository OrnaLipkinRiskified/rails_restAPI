class ItemSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :price
end
