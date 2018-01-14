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
class EncryptMessagesController < ApplicationController
  before_action :set_encrypt_messages
  before_action :set_encrypt_message, only: [:show, :edit, :update, :destroy]

  # GET rsas/1/encrypt_messages
  def index
    @encrypt_messages = @rsa.encrypt_messages
  end

  # GET rsas/1/encrypt_messages/1
  def show
  render json: {content: @encrypt_message.content}
  end

  # GET rsas/1/encrypt_messages/new
  def new
    @encrypt_message = @rsa.encrypt_messages.build
  end

  # GET rsas/1/encrypt_messages/1/edit
  def edit
  end

  # POST rsas/1/encrypt_messages
  def create
    rsa = RSA.new(@rsa.n, @rsa.e, @rsa.d)
    
    @encrypt_message = @rsa.encrypt_messages.build(({content: rsa.encrypt(params[:message])}))

    if @encrypt_message.save
      render json: {content: @encrypt_message.id}
    else
      render action: 'new'
    end
  end

  # PUT rsas/1/encrypt_messages/1
  def update
    if @encrypt_message.update_attributes(encrypt_message_params)
      redirect_to([@encrypt_message.rsa, @encrypt_message], notice: 'Encrypt message was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE rsas/1/encrypt_messages/1
  def destroy
    @encrypt_message.destroy

    redirect_to rsa_encrypt_messages_url(@rsa)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_encrypt_messages
      @rsa = Rsa.find(params[:rsa_id])
    end

    def set_encrypt_message
      @encrypt_message = @rsa.encrypt_messages.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def encrypt_message_params
      params.require(:encrypt_message).permit(:content)
    end
end
