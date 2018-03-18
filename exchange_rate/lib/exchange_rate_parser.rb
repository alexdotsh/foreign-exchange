require 'nokogiri'

class ExchangeRateParser
  include HTTParty
  BASE_URI = 'https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/index.en.html'.freeze

  def self.fetch_exchange_rates
    response = HTTParty.get(BASE_URI)
    doc = Nokogiri::HTML(response)

    sek = doc.css('[href="eurofxref-graph-sek.en.html"]').at('span').text.to_f
    nok = doc.css('[href="eurofxref-graph-nok.en.html"]').at('span').text.to_f

    ExchangeRateData.run(sek, nok)
  end
end
