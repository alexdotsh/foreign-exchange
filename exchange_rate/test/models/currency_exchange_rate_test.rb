require './test/test_helper'

describe CurrencyExchangeRate do
  describe :from_currency_code do
    it 'accepts a valid value' do
      CurrencyExchangeRate.new(from_currency_code: 'SEK').must_be_valid :from_currency_code
    end

    it 'returns an error for no value' do
      CurrencyExchangeRate.new(from_currency_code: '').wont_be_valid :from_currency_code
    end
  end

  describe :to_currency_code do
    it 'accepts a valid value' do
      CurrencyExchangeRate.new(to_currency_code: 'SEK').must_be_valid :to_currency_code
    end

    it 'returns an error for no value' do
      CurrencyExchangeRate.new(to_currency_code: '').wont_be_valid :to_currency_code
    end
  end

  describe :rate do
    it 'accepts a valid value' do
      CurrencyExchangeRate.new(rate: 10.1255).must_be_valid :rate
    end

    it 'returns an error for no value' do
      CurrencyExchangeRate.new(rate: '').wont_be_valid :rate
    end
  end

  describe :date do
    it 'accepts a valid value' do
      CurrencyExchangeRate.new(date: '2018-03-15').tap do |currency_exchange_rate|
        currency_exchange_rate.must_be_valid :date
        currency_exchange_rate.date.must_equal Date.new(2018, 03, 15)
      end
    end

    it 'returns an error for no value' do
      CurrencyExchangeRate.new(date: '').wont_be_valid :rate
    end

    it 'returns an error for invalid value' do
      CurrencyExchangeRate.new(date: 'invalid value').wont_be_valid :rate
    end
  end

  describe :conversion do
    it 'correctly converts an amount to a counter currency' do
      currency_exchange_rate = CurrencyExchangeRate.new(rate: 10.0795)
      assert_equal(currency_exchange_rate.conversion(100), 1007.95)
    end
  end
end
