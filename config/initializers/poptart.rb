if Rails.env.development?
  Poptart.api_token = 'testing'
else
  Poptart.api_token = ENV['POPTART_API_TOKEN']
end
