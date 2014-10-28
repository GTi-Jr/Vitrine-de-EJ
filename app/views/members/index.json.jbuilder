json.array!(@members) do |member|
  json.extract! member, :id, :name, :photo, :position
  json.url member_url(member, format: :json)
end
