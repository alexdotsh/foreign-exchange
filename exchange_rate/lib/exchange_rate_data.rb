class ExchangeRateData
  def self.run(sek, nok)
    sek_to_euro = (1 / sek).round(5)
    sek_to_nok = (0.1 * nok).round(5)
    nok_to_euro = (1 / nok).round(5)
    nok_to_sek = (10 / nok).round(5)

    CurrencyExchangeRate.create(
      [
        { from_currency_code: 'EUR', to_currency_code: 'SEK', rate: sek, date: Date.today },
        { from_currency_code: 'EUR', to_currency_code: 'NOK', rate: nok, date: Date.today },
        { from_currency_code: 'SEK', to_currency_code: 'EUR', rate: sek_to_euro, date: Date.today },
        { from_currency_code: 'SEK', to_currency_code: 'NOK', rate: sek_to_nok, date: Date.today },
        { from_currency_code: 'NOK', to_currency_code: 'EUR', rate: nok_to_euro, date: Date.today },
        { from_currency_code: 'NOK', to_currency_code: 'SEK', rate: nok_to_sek, date: Date.today }
      ]
    )
  end
end
