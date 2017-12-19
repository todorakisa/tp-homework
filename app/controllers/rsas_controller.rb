require_relative './RSA.rb'

class RsasController < ApplicationController
  before_action :set_rsa, only: [:show, :edit, :update, :destroy]

  # GET /rsas
  # GET /rsas.json
  def index
    @rsas = Rsa.all
  end

  # GET /rsas/1
  # GET /rsas/1.json
  def show
  end

  # GET /rsas/new
  def new
    @rsa = Rsa.new
  end

  # GET /rsas/1/edit
  def edit
  end

  # POST /rsas
  # POST /rsas.json
  def create
    
    n = params["n"]
    e = params["e"]
    d = params["d"]
    if !params.has_key?("n") || !params.has_key?("e") || !params.has_key?("d")
        n,e,d = RSA.new(223,543,2354).new_key;    
        
    end
    @rsa = Rsa.new({n: n, e: e, d: d})
    render json: @rsa.id
  end

  # PATCH/PUT /rsas/1
  # PATCH/PUT /rsas/1.json
  def update
    respond_to do |format|
      if @rsa.update(rsa_params)
        format.html { redirect_to @rsa, notice: 'Rsa was successfully updated.' }
        format.json { render :show, status: :ok, location: @rsa }
      else
        format.html { render :edit }
        format.json { render json: @rsa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rsas/1
  # DELETE /rsas/1.json
  def destroy
    @rsa.destroy
    respond_to do |format|
      format.html { redirect_to rsas_url, notice: 'Rsa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rsa
      @rsa = Rsa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rsa_params
      params.require(:rsa).permit(:n, :e, :d)
    end
end
