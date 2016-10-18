json.array!(@workshops) do |workshop|
  json.extract! workshop, :id, :title, :description, :information, :level, :price, :image
  json.url workshop_url(workshop, format: :json)
end
