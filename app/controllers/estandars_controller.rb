class EstandarsController < ApplicationController
  before_action :set_estandar, only: [:show, :edit, :update, :destroy]

  # GET /estandars
  # GET /estandars.json
  def index
    @estandars = Estandar.all
  end

  # GET /estandars/1
  # GET /estandars/1.json
  def show
  end

  # GET /estandars/new
  def new
    @estandar = Estandar.new
  end

  # GET /estandars/1/edit
  def edit
  end

  # POST /estandars
  # POST /estandars.json
  def create
    @estandar = Estandar.new(estandar_params)

    respond_to do |format|
      if @estandar.save
        format.html { redirect_to @estandar, notice: 'Estandar was successfully created.' }
        format.json { render :show, status: :created, location: @estandar }
      else
        format.html { render :new }
        format.json { render json: @estandar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /estandars/1
  # PATCH/PUT /estandars/1.json
  def update
    respond_to do |format|
      if @estandar.update(estandar_params)
        format.html { redirect_to @estandar, notice: 'Estandar was successfully updated.' }
        format.json { render :show, status: :ok, location: @estandar }
      else
        format.html { render :edit }
        format.json { render json: @estandar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estandars/1
  # DELETE /estandars/1.json
  def destroy
    @estandar.destroy
    respond_to do |format|
      format.html { redirect_to estandars_url, notice: 'Estandar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estandar
      @estandar = Estandar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def estandar_params
      params.require(:estandar).permit(:tipo, :descripcion, :fecha_crea)
    end
end
