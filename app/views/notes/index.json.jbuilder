json.array!(@notes) do |note|
  json.extract! note, :id, :workshop_id, :title, :description, :image, :note
  json.url note_url(note, format: :json)
end
