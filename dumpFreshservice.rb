require 'typhoeus'
require 'pry-byebug'
require 'json'
require 'pp'
require 'csv'
require 'dotenv/load'

hydra = Typhoeus::Hydra.new

requests = 1.times.map do |i|
  request = Typhoeus::Request.new(
    "https://hicommon.freshservice.com/helpdesk/tickets/#{4640}.json",
    headers: {
      'Content-Type' => 'application/json',
      'Authorization' => "Basic #{ENV['FRESHDESK_TOKEN']}"
    }
  )
  hydra.queue(request)
  request
end
hydra.run

responses = requests.map { |request|
  request.response.body
}

File.write('tickets.json', responses)

tickets = responses.map do |response|
  res = JSON.parse(response)['helpdesk_ticket']
  ticket = {
    display_id: res['display_id'],
    created_at: res['created_at'],
    due_by: res['due_by'],
    department_id_value: res['department_id_value'],
    deleted: res['deleted'],
    id: res['id'],
    is_escalated: res['isescalated'],
    group_id: res['group_id'],
    notes: res['notes'],
    owner_id: res['owner_id'],
    requester_id: res['requester_id'],
    responder_id: res['responder_id'],
    spam: res['spam'],
    status: res['status'],
    subject: res['subject'],
    ticket_type: res['ticket_type'],
    to_email: res['to_email'],
    updated_at: res['updated_at'],
    description: res['description'],
    requester_status_name: res['requester_status_name'],
    source_name: res['source_name'],
    requestor_name: res['requester_name'],
    responder_name: res['responder_name'],
    to_emails: res['to_emails'],
    department_name: res['department_name'],
    attachments: res['attachments'],
    custom_field: res['custom_field']
  }
  ticket
end

CSV.open('tickets.csv',  "wb") do |csv|
  csv << tickets.first.keys
  tickets.each do |ticket|
    csv << ticket.values
  end
end 
# 1.times.map do |i|

#   hydra.queue()
# end
# hydra.run
