require 'httparty'
require 'date'

class ExchangeRate
  ENDPOINT = 'http://0.0.0.0:3000/api/'.freeze

  attr_accessor :options

  def initialize(opts = {})
    @options = {
      query: {
        date: opts[:date].to_s,
        from: opts[:base_currency],
        to: opts[:counter_currency]
      }
    }
  end

  def at
    rate_uri = 'exchange_rates'
    response = HTTParty.get(ENDPOINT + rate_uri, @options)
    begin
      json = JSON.parse(response.body, symbolize_names: true)
    rescue JSON::ParserError => e
      p('Please enter a valid currecy code or date.')
    end

    p('1' + ' ' + json[:from_currency_code] + ' = ' + json[:rate] + ' ' + json[:to_currency_code]) if json
  end

  def convert(amount)
    @options[:query].merge!({ amount: amount })
    conversion_uri = 'conversion'
    response = HTTParty.get(ENDPOINT + conversion_uri, @options)

    p("#{amount} #{@options[:query][:from]} = #{response} #{@options[:query][:to]}")
  end
end
