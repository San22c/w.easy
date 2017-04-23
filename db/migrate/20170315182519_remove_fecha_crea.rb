class RemoveFechaCrea < ActiveRecord::Migration
  def change

    remove_column :ficheros, :fecha_crea
    remove_column :estandars, :fecha_crea
    remove_column :resultados, :fecha_crea


  end
end
