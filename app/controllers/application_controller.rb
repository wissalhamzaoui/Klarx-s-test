# For the documentation check http://sinatrarb.com/intro.html
class ApplicationController < Sinatra::Base

	# This configuration part will inform the app where to search for the views and from where it will serve the static files
	require 'money/bank/currencylayer_bank'
	mclb = Money::Bank::CurrencylayerBank.new
	mclb.access_key = '2528b7fbe124c4168fb4d1795b10ced6'
	mclb.update_rates

	Money.default_bank = mclb
	

	configure do
    	set :views, "app/views"
    	set :public_folder, "app/public"
  	end

  	get '/' do
   		erb :index
	  end
	  
	post '/' do  

		
		from=params[:from]
		to=params[:to]
		initialValue=(params[:initialValue].to_f)
		finalValue=Money.new(initialValue*100, from).exchange_to(to).format
		@exchange=Exchange.new(from: from, to: to, initialValue: initialValue, finalValue: finalValue)
		@exchange.save
		redirect "/exchange/"+ finalValue
	
	end

	get '/exchange/:exchange' do 
		erb :exchange , {:locals => {:finalValue =>params[:exchange]}}
	end

	get '/allExchanges' do  

		@exchanges = Exchange.all
		erb :allExchanges 
	end

end