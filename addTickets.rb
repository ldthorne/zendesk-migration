require 'pry-byebug'
require 'json'
require 'csv'
require 'zendesk_api'
require 'dotenv/load'

client = ZendeskAPI::Client.new do |config|
  config.url = 'https://commontesting.zendesk.com/api/v2'
  config.username = ENV['ZENDESK_EMAIL']
  config.token = ENV['ZENDESK_TOKEN']
  config.retry = true
end

# ZendeskAPI::Ticket.create!(client, subject: "Test Ticket", description: 'a description goes here')


json_tickets = File.read('tickets.json')
tickets = JSON.parse(json_tickets)
tickets = tickets.map {|t| JSON.parse(t)}
binding.pry
x = 'hello'
p x
p JSON.parse json_tickets