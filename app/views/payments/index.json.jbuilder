json.array!(@payments) do |payment|
  json.extract! payment, :id, :user_id, :transaction_amount, :mercadopago_preference, :init_point, :collection_id, :collection_status, :preference_id, :payment_type
  json.url payment_url(payment, format: :json)
end