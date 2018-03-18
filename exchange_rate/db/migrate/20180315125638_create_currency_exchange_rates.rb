class CreateCurrencyExchangeRates < ActiveRecord::Migration[5.1]
  def change
    create_table :currency_exchange_rates do |t|
      t.string :from_currency_code
      t.string :to_currency_code
      t.decimal :rate
      t.date :date

      t.timestamps
    end
  end
end
