json.array!(@users) do |user|
  json.extract! user, :id, :name, :avatar, :role, :email, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :created_at, :updated_at
  json.url user_url(user, format: :json)
end