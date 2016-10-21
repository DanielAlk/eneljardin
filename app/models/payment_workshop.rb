class PaymentWorkshop < ActiveRecord::Base
  belongs_to :payment
  belongs_to :workshop

  validates_presence_of [:payment, :workshop]
end
