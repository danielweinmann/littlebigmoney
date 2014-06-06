require 'httparty'
require 'json'

response = HTTParty.post "http://localhost:3000/es/users/authenticate_user.json", body: { "email" => "danielweinmann@gmail.com", "name" => "Daniel Weinmann" }.to_json, headers: { "Authorization" => 'Token token="d03cee4a13df6c84067cf644f131c702"' }

puts response