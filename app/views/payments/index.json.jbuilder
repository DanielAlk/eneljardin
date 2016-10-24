json.array!(@payments) do |payment|
  json.extract! payment, :id, :user_id, :workshop_id, :transaction_amount, :mercadopago_preference, :init_point, :payment_info, :collection_id, :collection_status, :collection_status_detail, :preference_id, :payment_type
  json.url payment_url(payment, format: :json)
end