json.array!(@contacts) do |contact|
  json.extract! contact, :id, :kind, :read, :name, :email, :message
  json.url contact_url(contact, format: :json)
end
