require 'httparty'
require 'uri'
require 'json'

class NOTIFY_FCM
  include HTTParty
  attr_accessor :body,  :title
  base_uri 'https://android.googleapis.com/gcm'
  # constants
  NOTIFICATION_BASE_URI = 'https://android.googleapis.com/gcm'

  def initialize(api_key, options = {})
    @api_key = api_key
    @options = options
  end

  def send_notification(registration_ids, options = {})

  raise ArgumentError, 'Api Key not Found' unless !@api_key.nil?
  raise ArgumentError, 'Body is missing' unless !body.nil?  
  
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
    return response
    # build_response(response, registration_ids)
  end

  alias send send_notification

  def build_body(registration_ids, options = {})
      { registration_ids: registration_ids }.merge(options)
  end

  def message_body()
     {notification: { body: body, title: title}}
  end



end
