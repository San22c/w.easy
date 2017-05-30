class Updatenamecoderror < ActiveRecord::Migration
  def change
    rename_column :resultados, :codError, :coderror

  end
end
