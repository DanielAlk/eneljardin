json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :description, :video_url, :price, :level, :image
  json.url movie_url(movie, format: :json)
end
