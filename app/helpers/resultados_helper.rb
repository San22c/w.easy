module ResultadosHelper

  def valoracion
    puntuacion = []
    resultados_bad = Resultado.where(:fichero_id => session[:fichero_id], :codError => 1).group(:estandar_id)
    resultados_ok = Resultado.where(:fichero_id => session[:fichero_id], :codError => 0).group(:estandar_id)
    puntuacion.push(resultados_ok.size)
    puntuacion.push(resultados_bad.size)
    return puntuacion
  end

end
