require 'prime'

class RSA
   def initialize n, e, d
     @n_=n.to_i
     @e_=e.to_i
     @d_=d.to_i
   end
   
   def n
      @n_ 
   end
   
   def e
      @e_
   end
   
   def d
      @d_
   end
   
   def new_key
      random_number_1 = rand(100)
      random_number_2 = rand(100)
      while !Prime.prime?(random_number_1) || !Prime.prime?(random_number_1)
      random_number_1 = rand(100)
      random_number_2 = rand(100)
      end
      n = random_number_1 * random_number_2
      numbers = Array.new
      numbers[0] = n;
      d = 1
      lcm = (random_number_1 - 1).lcm(random_number_2 - 1)
      e = rand(lcm)
	  while e.gcd(lcm) != 1
	    e = rand(lcm)
      end 
      numbers[1] = e
      while ((d * e)%lcm != 1)
			d += 1
      end
      numbers[2] = d      
      return numbers  
   end
   
   def encrypt message
      return message.chars.map {|c| c.ord ** @e_ % @n_}.join(",")
   end
   
   def decrypt message
      return (message.split(",").map {|c| (c.to_i ** @d_ % @n_).chr}).join("")
   end 
end
