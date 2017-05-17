# Notify-fcm

Simple FCM (Firebase Cloud Messaging) Gem for sending Push Notifications to iOS as well as Android devices

## Installation

```ruby
$ gem install notify_fcm
```
or in your Gemfile just include it:

```ruby
gem 'notify_fcm'
```
## Requirements

* One of the following, tested Ruby versions:

```ruby
2.0.0
```
```ruby
2.1.9
```
```ruby
2.2.5
```
```ruby
2.3.1
```
## Usage

* Example sending notifications:

```ruby
require 'notify_fcm'

fcm = NOTIFY_FCM.new("API-KEY")

device_token= ["xxxxxxxx", "xxxxxxx"] # an array of one or more client device tokens

fcm.title="My Title"                  # Set Title

fcm.body ="My Body"                   # Set Body

fcm.color = "#000000"                 # Set Colour Code

fcm.sound = "default"                 # Set your Notification sound

response = fcm.send(device_token)     # Send Notification
```

# MIT License

* Copyright (c) 2017 Vipin Kumar. See LICENSE.txt for details.

# Thanks and Support us
