class Resultado < ActiveRecord::Base
  belongs_to :fichero
  belongs_to :estandar
end
