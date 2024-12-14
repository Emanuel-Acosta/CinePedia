from flask import Flask, request, redirect, url_for, session, flash
from flask_app.models.comentario import Comentario
from flask_app.models.pelicula import Pelicula
from flask_app import app

@app.route('/agregar_comentario/<int:pelicula_id>', methods=['POST']) # 1 Ruta para agregar un comentario
def agregar_comentario(pelicula_id):
    if 'usuario_id' not in session:
        return redirect('/login')
    
    pelicula = Pelicula.obtener_por_id(pelicula_id)
    if pelicula.id_organizador == session['usuario_id']:
        flash("No puedes comentar en tu propia película.", "error")
        return redirect(url_for('ver_pelicula', id=pelicula_id))
    
    data = {
        'contenido': request.form['contenido'],
        'usuario_id': session['usuario_id'],
        'pelicula_id': pelicula_id
    }
    Comentario.crear(data)
    return redirect(url_for('ver_pelicula', id=pelicula_id))

@app.route('/eliminar_comentario/<int:id>', methods=['POST']) # 2 Ruta para eliminar un comentario
def eliminar_comentario(id):
    comentario = Comentario.obtener_por_id(id)
    if comentario and comentario.usuario_id == session['usuario_id']:
        Comentario.eliminar(id)
    return redirect(url_for('ver_pelicula', id=comentario.pelicula_id))