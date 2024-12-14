from flask_app.config.mysqlconnection import connectToMySQL
from flask import render_template, redirect, request, flash, session, url_for
from flask_app.models.pelicula import Pelicula 
from flask_app.models.usuario import Usuario
from flask_app.models.comentario import Comentario
from flask_app import app

DATABASE = 'cinePedia' 

@app.route('/nueva_pelicula', methods=['GET', 'POST']) # 1 Ruta para ir a crear una nueva pelicula
def nueva_pelicula(): 
    if request.method == 'GET':
        return render_template('nuevo.html')
    
    if request.method == 'POST':
        data = {
            'nombre': request.form['nombre'], 
            'fecha_estreno': request.form['fecha_estreno'], 
            'director': request.form['director'],
            'sinopsis': request.form['sinopsis'], 
            'id_organizador': session['usuario_id']  
        }
        errores = Pelicula.validar_pelicula(data) 
        if errores:
            for error in errores:
                flash(error, 'error')
            return render_template('nuevo.html', data=data)
        pelicula_id = Pelicula.crear(data)
        if pelicula_id: 
            flash('pelicula creada exitosamente', 'success') 
            return redirect(url_for('dashboard'))
        flash('Error al crear la pelicula', 'error') 
        return render_template('nuevo.html', data=data)

@app.route('/ver_pelicula/<int:id>') # 2 Ruta para ir a ver una pelicula
def ver_pelicula(id): 
    pelicula = Pelicula.obtener_por_id(id)
    comentarios = Comentario.obtener_por_pelicula(id)

    return render_template('ver_pelicula.html', pelicula=pelicula, comentarios=comentarios) 

@app.route('/eliminar_pelicula/<int:id>') # 3 Ruta para eliminar una pelicula directamente
def eliminar_pelicula(id): 
    if Pelicula.eliminar(id): 
        flash('pelicula eliminada exitosamente', 'success') 
    else:
        flash('Error al eliminar la pelicula', 'error') 
    return redirect(url_for('dashboard'))


@app.route("/editar_pelicula/<int:id>") # 4 Ruta para ir a editar una pelicula
def editar_pelicula(id): 
    if 'usuario_id' not in session:
        return redirect('/login')
    
    pelicula = Pelicula.obtener_por_id(id) 
    if pelicula.id_organizador != session['usuario_id']: 
        flash("No tienes permiso para editar esta pelicula", "error")  
        return redirect(url_for('dashboard'))
    else:
        return render_template("editar_pelicula.html", data=pelicula) 
    
@app.route("/actualizar_pelicula", methods=['GET', 'POST'])  # 5 Ruta para actualizar una pelicula cuando presionamos el botón de guardar desde editar_pelicula.html y lo pasa el formulario
def actualizar_pelicula(): 
    if 'usuario_id' not in session:
        return redirect('/login')
    
    if request.method == 'POST':
        datos = {
            'nombre': request.form['nombre'], 
            'fecha_estreno': request.form['fecha_estreno'], 
            'director': request.form['director'],
            'sinopsis': request.form['sinopsis'],
            'id_pelicula': request.form['id_pelicula'], 
            'id_organizador': session['usuario_id'] 
        }
        errores = Pelicula.validar_pelicula(datos) 
        if errores:
            for error in errores:
                flash(error, 'error')
            return render_template('editar_pelicula.html', data=datos) 
        Pelicula.actualizar(datos) 
        flash('pelicula actualizada exitosamente', 'success') 
        return redirect(url_for('dashboard'))




