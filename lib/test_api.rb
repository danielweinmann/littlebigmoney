require 'httparty'
require 'json'
require 'open-uri'

api_key = "d03cee4a13df6c84067cf644f131c702"

response = HTTParty.post "http://localhost:3000/es/users/authenticate_user.json", body: URI::encode("user[email]=danielweinmann@gmail.com&user[name]=Daniel Weinmann"), headers: { "Authorization" => "Token token=\"#{api_key}\"" }

access_token = JSON.parse(response.body)["access_token"]
puts access_token

response = HTTParty.post "http://localhost:3000/es/projects/8/backers.json", body: URI::encode("backer[value]=25000&backer[reward_id]=4&backer[anonymous]=1"), headers: { "Authorization" => "Token token=\"#{access_token}\"" }

puts response
