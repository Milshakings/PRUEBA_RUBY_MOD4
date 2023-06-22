require "uri"
require "net/http"
require 'json'

def request(url_requested)

url = URI(url_requested)
https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true
https.verify_mode = OpenSSL::SSL::VERIFY_PEER
request = Net::HTTP::Get.new(url)
request["cache-control"] = 'no-cache'
request["postman-token"] = '5f4b1b36-5bcd-4c49-f578-75a752af8fd5'

response = https.request(request)
return JSON.parse(response.read_body)
end

data = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=gaOGWFJ0Ot6d0yMLwwbcpWPzlmVypxDecPvOUZFV').values[0]
puts "Imagenes"
print data
puts()

photos = data.map{|x| x['img_src']}
print photos

photos_count = data.map{|x| x['camera']}
print "Nombre de la Cámara"
camara = photos_count.map{|x| x['name']}
print camara
print "Número de Fotos"
print photos_count.count()

html = ""
photos.each do |photo|
html += "<img src=\"#{photo}\">\n"
end
File.write('output.html', html)