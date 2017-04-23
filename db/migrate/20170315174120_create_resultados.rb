class CreateResultados < ActiveRecord::Migration
  def change
    create_table :resultados do |t|
      t.integer :codError
      t.string :msg_error
      t.datetime :fecha_crea
      t.references :fichero, index: true, foreign_key: true
      t.references :estandar, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
