from flask import render_template, request, redirect, session, flash
from flask_app import app, bcrypt
from flask_app.models.usuario import Usuario
from flask_app.models.pelicula import Pelicula 
from datetime import date


@app.route("/") # 1 Ruta para el index
def index():
    return render_template("index.html")

@app.route("/dashboard") # 2 Ruta para el dashboard
def dashboard():
    peliculas = Pelicula.get_all() 
    usuario = Usuario.get_by_id(session['usuario_id'])
    return render_template(
        "dashboard.html",
        peliculas=peliculas, 
        usuario=usuario
    )

@app.route('/register', methods=['POST']) # Ruta para registrar un usuario
def crear_usuario():
    data = {
        'nombre': request.form['name'],
        'apellido': request.form['apellido'],
        'email': request.form['email'],
        'password': request.form['password'],
        'confirmPassword': request.form['confirmPassword']
    }
    if not Usuario.validar_usuario(data):
        return redirect('/')
    else:
        pw_hash = bcrypt.generate_password_hash(request.form['password'])
        data = {
            'nombre': request.form['name'],
            'apellido': request.form['apellido'],
            'email': request.form['email'],
            'password': pw_hash
        }
        usuario_id = Usuario.save(data)
        session['usuario_id'] = usuario_id
        return redirect('/')

@app.route('/login', methods=['GET', 'POST']) # Ruta para iniciar sesión
def login():
    if request.method == 'POST':
        usuario = Usuario.get_by_email(request.form['loginEmail'])
        print(usuario)
        if usuario and bcrypt.check_password_hash(usuario.password, request.form['loginPassword']):
            session['usuario_id'] = usuario.id
            session['nombre'] = usuario.nombre
            return redirect('/dashboard')
        elif not usuario:
            flash("Email inválido", "login")
            return redirect('/')
        else:
            flash("Contraseña inválida", "login")
            return redirect('/')
    return redirect('/')

@app.route('/logout') # Ruta para cerrar sesión
def logout():
    session.clear() 
    return redirect('/')

