class CurrencyExchangeRate < ApplicationRecord
  validates :from_currency_code, :to_currency_code, :rate, :date, presence: true

  scope :currency_code, -> (from, to) { where(from_currency_code: from, to_currency_code: to) }
  scope :for_date, -> (date) { where(date: date) }

  def conversion(amount)
    (amount.to_i * self.rate.to_f).round(5)
  end
end
