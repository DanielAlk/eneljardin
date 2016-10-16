json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :description, :video_url
  json.url movie_url(movie, format: :json)
end
