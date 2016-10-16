json.array!(@comments) do |comment|
  json.extract! comment, :id, :title, :text, :commentable_id, :commentable_type, :user_id, :role
  json.url comment_url(comment, format: :json)
end
