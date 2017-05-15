class ArchivosController < ApplicationController

  Ruta_directorio_archivos = "public/archivos/";

  def subir_archivos
     @formato_erroneo = false;
  if request.post?
     #Archivo subido por el usuario.
     archivo = params[:archivo];
     #Nombre original del archivo.
     nombre = archivo.original_filename;
     @nombrefile = archivo.original_filename;
     #Directorio donde se va a guardar.
     directorio = Ruta_directorio_archivos;
     #Extensión del archivo.
     extension = nombre.slice(nombre.rindex("."), nombre.length).downcase;
     #Verifica que el archivo tenga una extensión correcta.
     if extension == ".xml"
        #Ruta del archivo.
        path = File.join(directorio, nombre);
        #Crear en el archivo en el directorio. Guardamos el resultado en una variable, será true si el archivo se ha guardado correctamente.
        resultado = File.open(path, "wb") { |f| f.write(archivo.read) };
        #Verifica si el archivo se subió correctamente.
        if resultado
           subir_archivo = "ok";

           # Creacion del Fichero
          @fichero = Fichero.new
          @fichero.nombre = @nombrefile
          @fichero.created_at = Time.zone.today
          @fichero.save
          session[:fichero_id] = @fichero.id


            ## Metodo valida fichero
               # Declaracion de ARRAYS
           @msg_array = Array.new()
           @tips_fuentes = Array['Calibri','Arial', 'Candara', 'Corbel', 'Gill Sans', 'Helvética', 'Myriad', 'Segoe', 'Tahoma', 'Tiresias', 'Verdana']
           @tam_fuentes = Array.new()
           @cursiva_fuentes = Array.new()
           @bold_fuentes = Array.new()
           @u_fuentes = Array.new()
           @txt = Array.new()


            @doc = File.open("public/archivos/"+@fichero.nombre) { |f| Nokogiri::XML(f) }
            #Eliminamos los name spaces
            @doc.remove_namespaces!

            # Titulo diapositiva
            @titulo = @doc.css('title')

            # TIPOGRAFIA
            @pptx = @doc.css("part[name='/ppt/slides/slide1.xml']").css('xmlData').css('sld').css('cSld').css('spTree').css('sp').css('txBody').css('p').css('r').css("latin")
            @ppt_tipo = @doc.xpath("//part[@name='/ppt/slides/slide1.xml']//xmlData//sld//cSld//spTree//sp").each do |node|
            @fuente=node.xpath("//txBody//p//r//rPr//latin") # sacamos la lista de fuentes
            end

            @ppt_tam = @doc.xpath("//part[@name='/ppt/slides/slide1.xml']//xmlData//sld//cSld//spTree//sp//txBody//p//r//rPr").each do |rpr|
              @tam_fuentes.push(rpr.attr('sz')) # sacamos la lista de tamanio fuentes
              @cursiva_fuentes.push(rpr.attr('i')) # sacamos la lista de cursiva_fuentes fuentes
              @bold_fuentes.push(rpr.attr('b')) # sacamos la lista de negrita fuentes
              @u_fuentes.push(rpr.attr('u')) # sacamos la lista de subraydo fuentes
            end

            @ppt_txt = @doc.xpath("//part[@name='/ppt/slides/slide1.xml']//xmlData//sld//cSld//spTree//sp//txBody//p//r//t").each do |t|
              @txt.push(t.text) # sacamos la lista de tamanio fuentes
            end

 
            # def estadar_tip1_fuente   .attr('typeface')
            @estadr = Estandar.find_by(id:1)

            ban_fuente = false
             @fuente.each do |font|
               @resultado = Resultado.new
               @resultado.fichero_id = @fichero.id
               @resultado.estandar_id = @estadr.id
               tipografia = font.attr('typeface')
               font_find = @tips_fuentes.detect{|w| w == tipografia}
               if font_find.nil?
                 ban_fuente = true
                 @resultado.codError = 1
                 @resultado.msg_error = 'Fuente detectada no valida'+ ' ' + tipografia
               else
                 @resultado.codError = 0
               end
               @resultado.save
              end
              if ban_fuente
                @msg_array.push('Se han detectado fuentes no validas')
              end

              # def estadar_tip2_fuente   .attr('sz')
              @estadr = Estandar.find_by(id:2)

              ban_tamanio = false
              @tam_fuentes.each do |tamanio|
                @resultado = Resultado.new
                @resultado.fichero_id = @fichero.id
                @resultado.estandar_id = @estadr.id

                if tamanio.nil?
                  tamanio= '1800'
                end
                if ((tamanio.to_i)/100) < 12 or ((tamanio.to_i)/100) > 16
                  ban_tamanio = true
                  @resultado.codError = 1
                  @resultado.msg_error = 'Tamaño fuente no valido'+ ' ' + ((tamanio.to_i)/100).to_s
                else
                  @resultado.codError = 0
                end
                @resultado.save
              end
              if ban_tamanio
                @msg_array.push('Se han detenctado tamaños de fuente no validos')
              end

              # def tip3_cursiva .attr('i')
              @estadr = Estandar.find_by(id:3)

              ban_cursiva = false
              @cursiva_fuentes.each do |i|
                @resultado = Resultado.new
                @resultado.fichero_id = @fichero.id
                @resultado.estandar_id = @estadr.id
                if !i.nil?
                  ban_cursiva = true
                  @resultado.codError = 1
                  @resultado.msg_error = 'No se admiten textos en cursiva'
                else
                  @resultado.codError = 0
                end
                @resultado.save
              end
                if ban_cursiva
                  @msg_array.push('Formato de texto invalido: no se admiten cursivas')
              end

              # def tip4_negrita .attr('b')
              @estadr = Estandar.find_by(id:4)

              cuenta_bold = 0
              ban_bold = false
              @bold_fuentes.each do |b|


                if !b.nil?
                  cuenta_bold = cuenta_bold + 1
                end
                @resultado = Resultado.new
                @resultado.fichero_id = @fichero.id
                @resultado.estandar_id = @estadr.id
                if cuenta_bold > 5
                  ban_bold = true
                  @resultado.codError = 1
                  @resultado.msg_error = 'Superado el limite de cuadtos de texto en formato negrita'
                else
                  @resultado.codError = 0
                end
                @resultado.save
              end
              if ban_bold
                @msg_array.push('Superado el limite de cuadtos de texto en formato negrita')
              end

              # def tip5_subrayado .attr('u')
              @estadr = Estandar.find_by(id:5)

              cuenta_u = 0
              ban_subry= false
              @u_fuentes.each do |u|

                if !u.nil?
                  cuenta_u = cuenta_u + 1
                end
              end
              @resultado = Resultado.new
              @resultado.fichero_id = @fichero.id
              @resultado.estandar_id = @estadr.id
              if cuenta_u > 5
                @resultado.codError = 1
                @resultado.msg_error = 'Superado el limite de cuadros de texto en formato subrayado'
                @msg_array.push('Superado el limite de cuadros de texto en formato subrayado')
              else
                @resultado.codError = 0
              end
              @resultado.save


              #Sombreado

              #Mayusculas
              @estadr = Estandar.find_by(id:7)

             cuenta_capital = 0
             @txt.each do |texto|
               if texto == texto.upcase
                 cuenta_capital = cuenta_capital + 1
               end
             end
             @resultado = Resultado.new
             @resultado.fichero_id = @fichero.id
             @resultado.estandar_id = @estadr.id
             if cuenta_capital > 5
               @resultado.codError = 1
               @resultado.msg_error = 'Superado el limite de cuadros de texto en MAYUSCULA'
               @msg_array.push('Superado el limite de cuadros de texto en MAYUSCULA')
             else
               @resultado.codError = 0
             end
             @resultado.save



             #Color NEGRO tipografia
             @estadr = Estandar.find_by(id:8)

            cuenta_capital = 0
            @txt.each do |texto|
              if texto == texto.upcase
                cuenta_capital = cuenta_capital + 1
              end
            end
            @resultado = Resultado.new
            @resultado.fichero_id = @fichero.id
            @resultado.estandar_id = @estadr.id
            if cuenta_capital > 5
              @resultado.codError = 1
              @resultado.msg_error = 'Superado el limite de cuadros de texto en MAYUSCULA'
              @msg_array.push('Superado el limite de cuadros de texto en MAYUSCULA')
            else
              @resultado.codError = 0
            end
            @resultado.save

            #Color BLANCO background
            @estadr = Estandar.find_by(id:9)

           cuenta_capital = 0
           @txt.each do |texto|
             if texto == texto.upcase
               cuenta_capital = cuenta_capital + 1
             end
           end
           @resultado = Resultado.new
           @resultado.fichero_id = @fichero.id
           @resultado.estandar_id = @estadr.id
           if cuenta_capital > 5
             @resultado.codError = 1
             @resultado.msg_error = 'Superado el limite de cuadros de texto en MAYUSCULA'
             @msg_array.push('Superado el limite de cuadros de texto en MAYUSCULA')
           else
             @resultado.codError = 0
           end
           @resultado.save

           #CPalabras por diapositiva
           @estadr = Estandar.find_by(id:10)

          cuenta_capital = 0
          @txt.each do |texto|
            if texto == texto.upcase
              cuenta_capital = cuenta_capital + 1
            end
          end
          @resultado = Resultado.new
          @resultado.fichero_id = @fichero.id
          @resultado.estandar_id = @estadr.id
          if cuenta_capital > 5
            @resultado.codError = 1
            @resultado.msg_error = 'Superado el limite de cuadros de texto en MAYUSCULA'
            @msg_array.push('Superado el limite de cuadros de texto en MAYUSCULA')
          else
            @resultado.codError = 0
          end
          @resultado.save



             # Si todo va OK pasamos a la pantalla de resultados.
             respond_to do |format|
                format.html { redirect_to resultados_path, notice: 'El fichero se proceso correctamente'}
                 format.json { render :show, status: :ok, location: @fichero }
             end

          else
           subir_archivo = "error";
        end

     else
        @formato_erroneo = true;
     end
   end

  end




  def listar_archivos
  end

  def borrar_archivos
  end
end
