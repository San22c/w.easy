class CreateFicheros < ActiveRecord::Migration
  def change
    create_table :ficheros do |t|
      t.string :nombre
      t.decimal :tiempoVal
      t.integer :rank
      t.datetime :fecha_crea

      t.timestamps null: false
    end
  end
end
