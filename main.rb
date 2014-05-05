require 'sinatra'
require './boot.rb'
require './money_calculator'

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
	@product = Item.all
	erb :index
end

get '/buy' do
	@product = Item.all
	erb :buy
end

get '/buy_product/:id' do
	@product = Item.find(params[:id])
	erb :purchase_form
end

post '/buy_product/:id' do
	@product = Item.find(params[:id])
	mc = MoneyCalculator.New(params[:one_coin], params[:five_coin], params[:ten_coin], params[:twenty_bill], params[:fifty_bill], params[:one_hundred_bill], params[:two_hundred_bill], params[:five_hundred_bill], params[:one_thousand_bill])
	erb :purchase_form
end


