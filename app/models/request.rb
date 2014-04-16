module Request
  def get(url)
    connection.get do |req|
      req.url(url)
      req.headers['Content-Type'] = 'application/json'
    end
  end

  def connection
    return @connection if @connection

    if Rails.env.production?
      url = ""
    else
      url = "http://localhost:3000"
    end

    @connection = Faraday.new(:url => url) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end
end
