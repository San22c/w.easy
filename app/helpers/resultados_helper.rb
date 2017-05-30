module ResultadosHelper

  def valoracion
     puntuacion = []
    resultados_bad = Resultado.where(:fichero_id => session[:fichero_id], :codError => 1).group(:estandar_id)
    resultados_ok  = Resultado.where(:fichero_id => session[:fichero_id], :codError => 0).group(:estandar_id)
    estandar_bad   = resultados_bad.map {|bad| bad.estandar_id }

    resultados_ok = Resultado.where('fichero_id = ? AND  estandar_id NOT IN (?) AND codError = 0',session[:fichero_id],estandar_bad).group(:estandar_id)
    estandar_ok    = resultados_ok.map {|ok| ok.estandar_id }

    puntuacion.push(estandar_ok.size)
    puntuacion.push(estandar_bad.size)
    byebug
     return puntuacion
  end

end
