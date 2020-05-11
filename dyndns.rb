require 'rest-client'
require 'cloudflare'
require 'dotenv/load'

token = ENV['CLOUDFLARE_TOKEN']

ip = RestClient.get('https://api.ipify.org')

Cloudflare.connect(token: token) do |connection|	# Get all available zones:
    zones = connection.zones
    # puts zones
    zone = connection.zones.find_by_name("kyletomanelli.com")
    # puts zone
    dns_records = zone.dns_records
    str = dns_records.first.to_s.split(' ').last
    puts str
    # dns_records.each do |i|
    #     puts i 
    # end
end

