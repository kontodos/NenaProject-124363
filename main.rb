require 'sinatra'
require './boot.rb'
require './money_calculator.rb'


myquantity = 0; #variable to track the quantity the user is buying
alerts = ""

# ROUTES FOR ADMIN SECTION
get '/admin' do
  @products = Item.all
  erb :admin_index
end

get '/new_product' do
  @product = Item.new
  erb :product_form
end

post '/create_product' do
	@item = Item.new
	@item.name = params[:name]
	@item.price = params[:price]
	@item.quantity = params[:quantity]
	@item.sold = 0
	@item.save
 	redirect to '/admin'
end

get '/edit_product/:id' do
  @product = Item.find(params[:id])
  erb :product_form
end

post '/update_product/:id' do
  @product = Item.find(params[:id])
  @product.update_attributes!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
  )
  redirect to '/admin'
end

get '/delete_product/:id' do
  @product = Item.find(params[:id])
  @product.destroy!
  redirect to '/admin'
end
# ROUTES FOR ADMIN SECTION

get '/' do
	product = Item.all
	
	#create an array full of names
	itemNames = []
		product.each do |item|
			itemNames << item.name
		end
	
	#create an array of 10 random items from the array of names
	nameSample = itemNames.sample(10)
	
	@nameSample = nameSample
	@product = Item.all
	erb :index
end

get '/buy' do
	@product = Item.all
	@alert = alerts
	erb :buy
end

get '/buy_product/:id' do
	alerts = ""
	@alerts = alerts
	@product = Item.find(params[:id])
	erb :purchase_form
end

post '/buy_product/:id' do
	alerts = ""
	@alerts = alerts
	@product = Item.find(params[:id])
	myquantity = params[:aquantity] #quantity the users wants to buy
	@quantity = myquantity
	#@quantity = params[:aquantity] #gets the quantity the user bought
	@title = @product.name #gets item name
	@due = @quantity.to_i * @product.price #gets total amount due
	#@due = params[:due] code doesn't work
	#product.quantity = @product.quantity.to_i - @quantity.to_i

	if myquantity.to_i > @product.quantity.to_i
		alerts = "You tried to buy #{myquantity} #{@product.name} but we only have #{@product.quantity}. Sorry for the inconvenience"
		redirect to '/buy'
	else

	@alert = alerts
	erb :payment
	end
end

post '/confirm/:id' do
	alerts = ""
	@alerts = alerts
	
	@product = Item.find(params[:id])
	
	@due = myquantity.to_i * @product.price
	@quantity = myquantity
	@title = @product.name
	mc = MoneyCalculator.new params[:one_coin], params[:five_coin], params[:ten_coin], params[:twenty_bill], params[:fifty_bill], params[:one_hundred_bill], params[:two_hundred_bill], params[:five_hundred_bill], params[:one_thousand_bill]
	@given = mc.total #gets the total payment of the user
	mc.getChange(@due)
	@change = @given - @due
	@hash = mc.bills
	
	if @due.to_i > @given.to_i
		alerts = "Your payment is insufficient."
		@alert = alerts
		erb :payment
	else
	
	left = @product.quantity.to_i - myquantity.to_i
	@product.sold = @product.sold + myquantity.to_i
	
	@product.update_attributes!(
	quantity: left
	)
	
	erb :confirm
	end
end
