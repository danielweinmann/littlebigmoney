require 'httparty'
require 'json'
require 'open-uri'

api_key = ARGV[0]

response = HTTParty.post "http://localhost:3000/es/users/authenticate_user.json", body: URI::encode("user[email]=testuser@gmail.com&user[name]=Test User Name"), headers: { "Authorization" => "Token token=\"#{api_key}\"" }

if response.code == 200

  access_token = JSON.parse(response.body)["access_token"]
  puts access_token

  response = HTTParty.post "http://localhost:3000/es/projects/52/backers", body: URI::encode("backer[value]=25000&backer[reward_id]=132&backer[anonymous]=1"), headers: { "Authorization" => "Token token=\"#{access_token}\"" }

  puts response.body.match(/<title>(.+)<\/title>/)[1]

else

  puts "Error!"
  puts response

end
