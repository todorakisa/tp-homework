require 'prime'

class RSA
   def initialize n, e, d
     @n_=n
     @e_=e
     @d_=d
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

class DecryptMessagesController < ApplicationController
  before_action :set_decrypt_messages
  before_action :set_decrypt_message, only: [:show, :edit, :update, :destroy]

  # GET rsas/1/decrypt_messages
  def index
    @decrypt_messages = @rsa.decrypt_messages
  end

  # GET rsas/1/decrypt_messages/1
  def show
  render json: {content: @decrypt_message.content}
  end

  # GET rsas/1/decrypt_messages/new
  def new
    @decrypt_message = @rsa.decrypt_messages.build
  end

  # GET rsas/1/decrypt_messages/1/edit
  def edit
  end

  # POST rsas/1/decrypt_messages
  def create
    rsa = RSA.new(@rsa.n, @rsa.e, @rsa.d)
    @decrypt_message = @rsa.decrypt_messages.build(({content: rsa.decrypt(params[:message])}))

    if @decrypt_message.save
      render json: {content: @decrypt_message.id}
    else
      render action: 'new'
    end
  end

  # PUT rsas/1/decrypt_messages/1
  def update
    if @decrypt_message.update_attributes(decrypt_message_params)
      redirect_to([@decrypt_message.rsa, @decrypt_message], notice: 'Decrypt message was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE rsas/1/decrypt_messages/1
  def destroy
    @decrypt_message.destroy

    redirect_to rsa_decrypt_messages_url(@rsa)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_decrypt_messages
      @rsa = Rsa.find(params[:rsa_id])
    end

    def set_decrypt_message
      @decrypt_message = @rsa.decrypt_messages.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def decrypt_message_params
      params.require(:decrypt_message).permit(:content)
    end
end
