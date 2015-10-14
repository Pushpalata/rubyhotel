json.array!(@rooms) do |room|
  json.extract! room, :id, :room_no, :wing, :rate, :floor_no, :status
  json.url room_url(room, format: :json)
end
