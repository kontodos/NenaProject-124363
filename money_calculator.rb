class MoneyCalculator

		attr_accessor :total

  def initialize(ones, fives, tens, twenties, fifties, hundreds, two_hundreds, five_hundreds, thousands)
    # each parameter represents the quantity per denomination of money
    # these parameters can be assigned to instance variables and used for computation

    # add a method called 'change' that takes in a parameter of how much an item costs
    # and returns a hash of how much change is to be given
    # the hash will use the denominations as keys and the amount per denomination as values
    # i.e. {:fives => 1, fifties => 1, :hundreds => 3}
	@ones = ones * 1
	@fives = fives * 5
	@tens = tens * 10
	@twenties = twenties * 20
 	@fifties = fifties * 50
	@hundreds = hundreds * 100
	@two_hundreds = two_hundreds * 200
	@five_hundreds = five_hundreds * 500
	@thousands = thousands * 1000
	
	total= @ones + @fives + @tens + @twenties + @fifties + @hundreds + @two_hundreds + @five_hundreds + @thousands
	bills = Hash.new
	
  end
  
  def change(cost)
	change = total - cost
	
	while change > 0
	
		if change - 1000 >= 0
			bills["thousands"] += 1
		
		elsif change - 500 >= 0
			bills["five_hundreds"] += 1
		
		elsif change - 200 >= 0
			bills["two_hundreds"] += 1
			
		elsif change - 100 >= 0
			bills["hundreds"] += 1
		
		elsif change - 50 >= 0
			bills["fifties"] += 1
		
		elsif change - 20 >= 0
			bills["twenties"] += 1
		
		elsif change - 10 >= 0
			bills["tens"] += 1
		
		elsif change - 5 >= 0
			bills["fives"] += 1
			
		else
			bills["ones"] += 1
		end
  end
end

end

