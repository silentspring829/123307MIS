class MoneyCalculator

	attr_accessor :ones, :fives, :tens, :twenties, :fifties, :hundreds, :fivehundreds, :thousands, :cost, :payment


  def initialize(ones, fives, tens, twenties, fifties, hundreds, five_hundreds, thousands)
  	    # each parameter represents the quantity per denomination of money
    # these parameters can be assigned to instance variables and used for computation

    # add a method called 'change' that takes in a parameter of how much an item costs
    # and returns a hash of how much change is to be given
    # the hash will use the denominations as keys and the amount per denomination as values
    # i.e. {:fives => 1, fifties => 1, :hundreds => 3}

  @thousands = thousands.to_i
  @fivehundreds = fivehundreds.to_i
  @hundreds = hundreds.to_i
  @fifties = fifties.to_i
  @twenties = twenties.to_i
  @tens = tens.to_i
  @fives = fives.to_i
  @ones = ones.to_i

  end

  def change(cost, payment)
  	@money = payment.to_i - cost.to_i
  	remainder = @money

  	if @money >= 1000 
  		input_thousands = @money/1000
  		remainder = @money%1000
  	end 

  	if remainder >= 500
  		input_fivehundreds = remainder/500
  		remainder = remainder%500
  	end

  	if remainder >= 100
  		input_hundreds = remainder/100
  		remainder = remainder%100
  	end

 	 if remainder >= 50
  	input_fifties = remainder/50
  	remainder = remainder%50
    end

  	if remainder >= 20
  		input_twenties = remainder/20
  		remainder = remainder%20  
  	end

  	if remainder >= 10
  		input_tens = remainder/10
  		remainder = remainder%10  
  	end

  	if remainder >= 5
  		input_fives = remainder/5
  		remainder = remainder%5  
  	end

  	if remainder >= 1
  		input_ones = remainder/1
  		remainder = remainder%1  
  	end

  @b = {:ones => input_ones.to_i, :fives => input_fives.to_i, :tens => input_tens.to_i, :twenties => input_twenties.to_i, :fifties => input_fifties.to_i, :hundreds => input_hundreds.to_i, :fivehundreds => input_fivehundreds.to_i, :thousands => input_thousands.to_i}
  return @b
end
end