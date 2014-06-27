if Rails.env.development? || Rails.env.test?
  Poptart.api_token = 'testing'
else
  Poptart.api_token = ENV['POPTART_API_TOKEN']
  Poptart.url = "http://#{ENV['HAPPINESS_SERVICE_PORT_3000_TCP_ADDR']}:#{ENV['HAPPINESS_SERVICE_PORT_3000_TCP_PORT']}"
end
