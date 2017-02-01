# Notify-fcm
Simple FCM Gem for sending Push Notifications to iOS as well as Android devices


Installation

$ gem install notify_fcm

or in your Gemfile just include it:

gem 'notify_fcm'

# Requirements

One of the following, tested Ruby versions:

2.0.0
2.1.9
2.2.5
2.3.1

# Usage

Example sending notifications:

require 'notify_fcm'

fcm = FCM.new("API-KEY")

device_token= ["xxxxxxxx", "xxxxxxx"] # an array of one or more client device tokens

fcm.title="My Title"

fcm.body ="My Body"

response = fcm.send(device_token)


# Thanks 