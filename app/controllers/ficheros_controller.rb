class FicherosController < ApplicationController
  require 'rubygems'
  require 'nokogiri'

  before_action :set_fichero, only: [:show, :edit, :update, :destroy]

  # GET /ficheros
  # GET /ficheros.json
  def index
    @ficheros = Fichero.all
  end

# GET /ficheros/1
  # GET /ficheros/1.json
  def show
  end

  # GET /ficheros/new
  def new
    @fichero = Fichero.new
  end

  # GET /ficheros/1/edit
  def edit
  end

  # POST /ficheros
  # POST /ficheros.json
  def create
    @fichero = Fichero.new(fichero_params)

    respond_to do |format|
      if @fichero.save
        format.html { redirect_to @fichero, notice: 'Fichero was successfully created.' }
        format.json { render :show, status: :created, location: @fichero }
      else
        format.html { render :new }
        format.json { render json: @fichero.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ficheros/1
  # PATCH/PUT /ficheros/1.json
  def update
    respond_to do |format|
      if @fichero.update(fichero_params)
        format.html { redirect_to @fichero, notice: 'Fichero was successfully updated.' }
        format.json { render :show, status: :ok, location: @fichero }
      else
        format.html { render :edit }
        format.json { render json: @fichero.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ficheros/1
  # DELETE /ficheros/1.json
  def destroy
    @fichero.destroy
    respond_to do |format|
      format.html { redirect_to ficheros_url, notice: 'Fichero was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fichero
      @fichero = Fichero.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fichero_params
      params.require(:fichero).permit(:nombre, :tiempoVal, :rank, :fecha_crea)
    end
end
