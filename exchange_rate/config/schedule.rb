# According to the developers from European Central Bank (ECB) the feed updates
# exactly 4pm Central European Summer Time (CET) everyday.

every(1.day, at: '4:00pm') { runner 'ExchangeRateParser.fetch_exchange_rates' }
