module Api
  class CurrencyExchangeRatesController < ApiController
    def result
      @result = CurrencyExchangeRate.currency_code(params[:from], params[:to])
                                    .for_date(params[:date]).first

      if @result.present?
        render json: @result
      else
        head :bad_request
      end
    end

    def convert
      @convert = CurrencyExchangeRate.currency_code(params[:from], params[:to])
                                     .for_date(params[:date]).first
                                     .conversion(params[:amount])

      render json: @convert
    end
  end
end
