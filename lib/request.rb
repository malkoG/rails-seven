require 'openssl'
require 'net/http'
require 'json'
require 'securerandom'

module Request

  @file = File.read File.join(File.dirname(__FILE__), '../solapi-config.json')
  @config = JSON.parse(@file)

  def self.get_uri(path)
    str = @config['protocol'] + '://' + @config['domain'] + @config['prefix']
    puts str + path
    uri = URI(str + path)
    return uri
  end

  def self.get_header
    api_key = @config['api_key']
    api_secret = @config['api_secret']
    date = Time.now.strftime('%Y-%m-%dT%H:%M:%S.%L%z')
    salt = SecureRandom.hex
    signature = OpenSSL::HMAC.hexdigest('SHA256', api_secret, date + salt)
    return 'HMAC-SHA256 apiKey=' + api_key + ', date=' + date + ', salt=' + salt + ', signature=' + signature
  end

  def self.post(path, body)
    header = get_header
    uri = get_uri(path)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    req.add_field('Authorization', header)
    if body
      req.body = body.to_json
    end
    res = http.request(req)
    return JSON.parse(res.body)
  end

  def self.put(path, body, headers = nil)
    auth = get_header
    uri = get_uri(path)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Put.new(uri.path, 'Content-Type' => 'application/json')
    req.add_field('Authorization', auth)
    if headers
      headers.each do |k, v|
        req.add_field(k, v)
      end
    end
    if body
      req.body = body.to_json
    end
    res = http.request(req)
    return JSON.parse(res.body)
  end


  def self.get(path)
    header = get_header
    uri = get_uri(path)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(uri.path, 'Content-Type' => 'application/json')
    req.add_field('Authorization', header)
    res = http.request(req)
    return JSON.parse(res.body)
  end

def self.delete(path, body)
    header = get_header
    uri = get_uri(path)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Delete.new(uri.path, 'Content-Type' => 'application/json')
    req.add_field('Authorization', header)
    res = http.request(req)
    if body
      req.body = body.to_json
    end
    return JSON.parse(res.body)
  end

end
