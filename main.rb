require 'sinatra'
require './boot.rb'
require './money_calculator.rb'

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
  Item.create!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
    sold: 0
  )
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

get '/about' do
  erb :about
end

get '/' do
  random = Item.all 
  @products = random.sample(10)
  erb :home
end

get '/products' do
  @products = Item.all
  erb :products
end

get '/number_product/:id' do
  @product = Item.find(params[:id])
  @items = params[:items].to_i
  @cost = @items * @product.price  
  erb :buy_products
end



post '/receipt_product/:id' do
  @product = Item.find(params[:id])
  @items = params[:items].to_i 
  @cost = @items * @product.price.to_f 

  @thousands = params[:thousands].to_i
  @fivehundreds = params[:fivehundreds].to_i
  @hundreds = params[:hundreds].to_i
  @fifties = params[:fifties].to_i
  @twenties = params[:twenties].to_i
  @tens = params[:tens].to_i
  @fives = params[:fives].to_i
  @ones = params[:ones].to_i

  if @items > @product.quantity.to_i
    erb :error
  else


  @add = (@thousands*1000) + (@fivehundreds*500) + (@hundreds*100) + (@fifties*50) + (@twenties*20) + (@tens*10) + (@fives*5) + (@ones*1)
  @payment = @add.to_f
  @money = @payment - @cost 

  if @payment < @cost
    erb :error
  else  


  @a = MoneyCalculator.new(params[:ones], params[:five], params[:tens], params[:twenties], params[:fifties], params[:hundreds], params[:fivehundreds], params[:thousands])
  @b = @a.change(@cost, @payment)
  @onespeso = @b[:ones]
  @fivespeso = @b[:five]
  @tenspeso = @b[:tens]
  @twentiespeso = @b[:twenties]
  @fiftiespeso = @b[:fifties]
  @hundredspeso = @b[:hundreds]
  @fivehundredspeso = @b[:fivehundreds]
  @thousandspeso = @b[:thousands]

  @product.update_attributes!(
    quantity: @product.quantity.to_i - @items,
    sold: @product.sold.to_i + @items
    )

  erb :receipt

end
end
end 
