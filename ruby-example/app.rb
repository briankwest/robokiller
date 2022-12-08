require 'sinatra/base'
require 'net/http'
require 'uri'
require 'signalwire/sdk'
class LaMLApp < Sinatra::Base
   get '/new_call' do
       content_type 'text/xml' 
       is_under_blacklist=is_blacklist_number(params[:From])
       response =""
       if is_under_blacklist == "YES"
           response = Signalwire::Sdk::VoiceResponse.new  do |response|
  	      response.say(message: 'Number is misconfigured or invalid')
           end
       elsif is_under_blacklist == "ERR"
             response = Signalwire::Sdk::VoiceResponse.new do |response|
	       response.say(message: 'Something went wrong please call again')
            end
       else
            response = Signalwire::Sdk::VoiceResponse.new do |response|
              response.say(message: 'Your call  is importnat to us')
           end
           #Generate your LaML bin as per your call flow  and append to "response" variableto answer the call 
       end
       return response.to_s  
   end

   def is_blacklist_number(number)
      begin
         uri= URI.parse('https://enterprise-api.robokiller.com/v1/reputation?from='+number+'&to=+19184249378&api_key='+ENV['RK_API_KEY'])
         puts uri
         result=Net::HTTP.get(uri) 
         puts "******************************"
         if JSON.parse(result)["classification"] == "blacklist"
            return "YES"
         else
            return "NO"
	 end
         
      rescue => e
         puts "Error checking Number with Robokiller API " + e.to_s
         return "ERR"
      end
   end
end
