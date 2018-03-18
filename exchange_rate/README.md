## Foreign exchange rates technical task.

### Requirements

* Ruby 2.4.1 or higher
* Rails 5.1.5
* HTTParty 0.16.1
* SQLite 3

First we need to run a script to get the exchange rate data from ECB to utilise the API with the ruby client.

`cd freska/exchange_rate`

Run:

`bundle install`

`bundle exec rake db:create && bundle exec rake db:migrate`

`rails c`

`[1] pry(main)> ExchangeRateParser.fetch_exchange_rates`

There is also an automated cron task located in `config/schedule.rb` to run 4pm CET everyday to get the exchange rate data.

Once the data is been fetched and saved to the database then run:

`rails s`

Once the rails server started we can make API calls with the ruby client to `http://0.0.0.0:3000/api/xyz`.

**Client.**

Required gem for the ruby client library:

`$ gem install httparty`

Run either `pry` or `irb` where the `ruby` file is located.

Ruby client file: `freska/exchange_rate.rb`

Exchange rates as of: **2018/03/17**

EURO to SEK

```ruby
[1] pry(main)> require_relative 'exchange_rate.rb'
=> true

[2] pry(main)> exchange_rate = ExchangeRate.new({ date: Date.today, base_currency: 'EUR', counter_currency: 'SEK' })
=> #<ExchangeRate:0x007fbd74f71f00 @options={:query=>{:date=>"2018-03-17", :from=>"EUR", :to=>"SEK"}}>

[3] pry(main)> exchange_rate.at
=> "1 EUR = 10.0795 SEK"

[4] pry(main)> exchange_rate.convert(150)
=> "150 EUR = 1511.925 SEK"
```

EURO to NOK

```ruby
[1] pry(main)> exchange_rate = ExchangeRate.new({ date: Date.today, base_currency: 'EUR', counter_currency: 'NOK' })
=> #<ExchangeRate:0x007ff70f030ee0 @options={:query=>{:date=>"2018-03-17", :from=>"EUR", :to=>"NOK"}}>

[2] pry(main)> exchange_rate.at
=> "1 EUR = 9.491 NOK"

[3] pry(main)> exchange_rate.convert(150)
=> "150 EUR = 1423.65 NOK"
```

SEK to EURO

```ruby
[1] pry(main)> exchange_rate = ExchangeRate.new({ date: Date.today, base_currency: 'SEK', counter_currency: 'EUR'})
=> #<ExchangeRate:0x007f83778489e0 @options={:query=>{:date=>"2018-03-17", :from=>"SEK", :to=>"EUR"}}>

[2] pry(main)> exchange_rate.at
=> "1 SEK = 0.09921 EUR"

[3] pry(main)> exchange_rate.convert(150)
=> "150 SEK = 14.8815 EUR"
```

NOK to EURO

```ruby
[1] pry(main)> exchange_rate = ExchangeRate.new({ date: Date.today, base_currency: 'NOK', counter_currency: 'EUR'})
=> #<ExchangeRate:0x007f83727b7328 @options={:query=>{:date=>"2018-03-17", :from=>"NOK", :to=>"EUR"}}>

[2] pry(main)> exchange_rate.at
=> "1 NOK = 0.10536 EUR"

[3] pry(main)> exchange_rate.convert(150)
=> "150 NOK = 15.804 EUR"
```

SEK to NOK

```ruby
[1] pry(main)> exchange_rate = ExchangeRate.new({ date: Date.today, base_currency: 'SEK', counter_currency: 'NOK'})
=> #<ExchangeRate:0x007ff70cf644a0 @options={:query=>{:date=>"2018-03-17", :from=>"SEK", :to=>"NOK"}}>

[2] pry(main)> exchange_rate.at
=> "1 SEK = 0.9491 NOK"

[3] pry(main)> exchange_rate.convert(150)
=> "150 SEK = 142.365 NOK"
```

NOK to SEK

```ruby
[1] pry(main)> exchange_rate = ExchangeRate.new({ date: Date.today, base_currency: 'NOK', counter_currency: 'SEK'})
=> #<ExchangeRate:0x007ff70cf1f990 @options={:query=>{:date=>"2018-03-17", :from=>"NOK", :to=>"SEK"}}>

[2] pry(main)> exchange_rate.at
=> "1 NOK = 1.05363 SEK"

[3] pry(main)> exchange_rate.convert(150)
=> "150 NOK = 158.0445 SEK"
```

**API.**

Implementation files.

```
test/models/currency_exchange_rate_test.rb

app/models/currency_exchange_rate.rb

app/controllers/api/api_controller.rb
app/controllers/api/currency_exchange_rates_controller.rb

lib/exchange_rate_parser.rb
lib/exchange_rate_data.rb

# cron task
config/schedule.rb

config/routes.rb

db/migrate/20180315125638_create_currency_exchange_rates.rb
```

**Client.**

Implementation file.

`freska/exchange_rate.rb`
