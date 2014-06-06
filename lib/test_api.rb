require 'httparty'
require 'json'
require 'open-uri'

api_key = ARGV[0]

host = "littlebigmoney.org"
email = "testuser@gmail.com"
name = "Test User Name"
project = "52"
value = "25000"
reward = "132"
anonymous = "1"

response = HTTParty.post "http://#{host}/es/users/authenticate_user.json", body: URI::encode("user[email]=#{email}&user[name]=#{name}"), headers: { "Authorization" => "Token token=\"#{api_key}\"" }

if response.code == 200
  access_token = JSON.parse(response.body)["access_token"]
  puts access_token
  response = HTTParty.post "http://#{host}/es/projects/#{project}/backers", body: URI::encode("backer[value]=#{value}&backer[reward_id]=#{reward}&backer[anonymous]=#{anonymous}"), headers: { "Authorization" => "Token token=\"#{access_token}\"" }
  puts response.body.match(/<title>(.+)<\/title>/)[1]
else
  puts "Error!"
  puts response
end
