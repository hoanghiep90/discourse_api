require 'csv'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)

client = DiscourseApi::Client.new("http://localhost:3000")
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"

# fetch email-less invite tokens
invite_tokens = client.disposable_tokens(username: "eviltrout", quantity: 5, group_names: "security,support")
invite_tokens_array = invite_tokens.body

# write to CSV file
CSV.open(File.expand_path("../invite_tokens.csv", __FILE__), "w") do |csv|
  invite_tokens_array.each do |value|
    csv << [value]
  end
end
