class MoneyCalculator

		attr_accessor :total, :bills, :change
		attr_accessor :ones, :fives, :tens, :twenties, :fifties, :hundreds, :two_hundreds, :five_hundreds, :thousands
		

  def initialize(ones, fives, tens, twenties, fifties, hundreds, two_hundreds, five_hundreds, thousands)
    # each parameter represents the quantity per denomination of money
    # these parameters can be assigned to instance variables and used for computation

    # add a method called 'change' that takes in a parameter of how much an item costs
    # and returns a hash of how much change is to be given
    # the hash will use the denominations as keys and the amount per denomination as values
    # i.e. {:fives => 1, fifties => 1, :hundreds => 3}
	@ones = ones.to_i * 1
	@fives = fives.to_i * 5
	@tens = tens.to_i * 10
	@twenties = twenties.to_i * 20
 	@fifties = fifties.to_i * 50
	@hundreds = hundreds.to_i * 100
	@two_hundreds = two_hundreds.to_i * 200
	@five_hundreds = five_hundreds.to_i * 500
	@thousands = thousands.to_i * 1000
	
	@total = @ones.to_i + @fives.to_i + @tens.to_i + @twenties.to_i + @fifties.to_i + @hundreds.to_i + @two_hundreds.to_i + @five_hundreds.to_i + @thousands.to_i
	
	#@bills = {"thousands" => 0, "five_hundreds" => 0, "two_hundreds" => 0, "hundreds" => 0, "fifties" => 0, "twenties" => -0, "tens" => 0, "fives" => 0, "ones" => 0}
	
	@bills = Hash.new
	
	@bills["thousands"] = 0
	@bills["five_hundreds"] = 0
	@bills["two_hundreds"] = 0
	@bills["hundreds"] = 0
	@bills["fifties"] = 0
	@bills["twenties"] = 0
	@bills["tens"] = 0
	@bills["fives"] = 0
	@bills["ones"] = 0
	
  end
  
  
  
  def getChange(cost)
	@change = @total - cost.to_i
	changeToBills()
  end
  
  def changeToBills()
  
	while @change > 0
	
		if @change - 1000 >= 0
			bills["thousands"] += 1
			@change = @change - 1000
		
		elsif @change - 500 >= 0
			bills["five_hundreds"] += 1
			@change = @change - 500
			
		elsif @change - 200 >= 0
			bills["two_hundreds"] += 1
			@change = @change - 200
			
		elsif @change - 100 >= 0
			bills["hundreds"] += 1
			@change = @change - 100
			
		elsif @change - 50 >= 0
			bills["fifties"] = bills["fifties"].to_i + 1
			@change = @change - 50
			
		elsif @change - 20 >= 0
			bills["twenties"] = bills["twenties"].to_i + 1
			@change = @change - 20
			
		elsif @change - 10 >= 0
			bills["tens"] += 1
			@change = @change - 10
			
		elsif @change - 5 >= 0
			bills["fives"] += 1
			@change = @change - 5
			
		else
			bills["ones"] += 1
			@change = @change - 1
		end
	end
end

end

