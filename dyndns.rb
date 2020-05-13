require 'rest-client'
require 'cloudflare'
require 'dotenv/load'

token = ENV['CLOUDFLARE_TOKEN']

loop do
    ip = RestClient.get('https://api.ipify.org')
    
    Cloudflare.connect(token: token) do |connection|
        zone = connection.zones.find_by_name("kyletomanelli.com")
        record = zone.dns_records.find_by_name("rdp.kyletomanelli.com")
    
        if record.content != ip
            record.delete
            zone.dns_records.create('A', 'rdp', ip, proxied: false)
        end 
        puts 'fuck yeah'
    end
    sleep(1800)
end
