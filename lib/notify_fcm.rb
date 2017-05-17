require 'httparty'
require 'uri'
require 'json'
require 'cgi'

class NOTIFY_FCM
  include HTTParty
  attr_accessor :body,  :title, :icon, :sound, :vibrate, :color, :priority
  base_uri 'https://fcm.googleapis.com/fcm'

  # constants
  # NOTIFICATION_BASE_URI = 'https://android.googleapis.com/gcm'

  def initialize(api_key, options = {})
    @api_key = api_key
    @options = options
  end

  def send_notification(registration_ids, options = {})

  raise ArgumentError, 'Api Key not Found' unless !@api_key.nil?
  raise ArgumentError, 'Body is missing' unless !body.nil?
  raise ArgumentError, 'DeviceToken not Found' unless !registration_ids.empty?

    message = message_body()
    body = build_body(registration_ids, message)
    params = {
      body: body.to_json,
      headers: {
        'Authorization' => "key=#{@api_key}",
        'Content-Type' => 'application/json'
      }
    }

    response = self.class.post('/send', params.merge(@options))
    response_builder(response)
  end

  alias send send_notification

  def build_body(registration_ids, options = {})
      { registration_ids: registration_ids }.merge(options)
  end

  def message_body()
     {notification: { body: body, title: title, icon: icon, sound: sound, vibrate: true, color: color, priority: priority}}
  end

  def response_builder(response)
    parse_response(response)
  end

  def parse_response(response_body)
    response_data = {}
    res_body = response_body.body || {}
    case response_body.code
    when 200
      body = JSON.parse(res_body) unless res_body.empty?
      response_data[:status] = 'success'
      response_data[:response] = body || {}
    when 400
      response_data[:status] = 'failed'
      response_data[:response] = 'Json Fields are invalid'
    when 401
      response_data[:status] = 'failed'
      response_data[:response] = 'Authentication Error!'
    when 503
      response_data[:status] = 'failed'
      response_data[:response] = 'Server is temporarily unavailable.'
    when 500..599
      response_data[:status] = 'failed'
      response_data[:response] = 'FCM internal server error!'
    end
    response_data
  end

end
