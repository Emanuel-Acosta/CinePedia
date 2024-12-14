from flask_app.config.mysqlconnection import connectToMySQL
from datetime import datetime
from flask import flash

DATABASE = 'cinePedia'

class Pelicula: 
    def __init__(self, data):
        self.id_pelicula = data['id_pelicula'] 
        self.nombre = data['nombre'] 
        self.fecha_estreno = data['fecha_estreno'] 
        self.sinopsis = data['sinopsis']
        self.director = data['director']
        self.id_organizador = data['id_organizador'] 
        self.fecha_creacion = data['fecha_creacion'] 
        self.fecha_actualizacion = data['fecha_actualizacion']
        self.organizador = data.get('organizador', None)  

    @classmethod
    def get_all(cls): # 1 Metodo para obtener todos las peliculas
        query = """
            SELECT v.*, u.nombre as organizador 
            FROM peliculas v
            JOIN usuarios u ON v.id_organizador = u.id_usuario
            ORDER BY v.fecha_estreno DESC;
        """
        results = connectToMySQL(DATABASE).query_db(query)
        peliculas = [] 
        if results:
            for row in results:
                peliculas.append(cls(row))
        return peliculas 
    
    @classmethod
    def crear(cls, data): # 2 Metodo para crear pelicula
        query = """
            INSERT INTO peliculas (nombre, fecha_estreno, sinopsis, director, id_organizador, fecha_creacion, fecha_actualizacion)
            VALUES (%(nombre)s, %(fecha_estreno)s, %(sinopsis)s, %(director)s, %(id_organizador)s, NOW(), NOW());
        """
        return connectToMySQL(DATABASE).query_db(query, data)
        
    @classmethod
    def actualizar(cls, data): # 3 Metodo para actualizar una pelicula
        query = """
            UPDATE peliculas
            SET nombre = %(nombre)s, fecha_estreno = %(fecha_estreno)s, sinopsis = %(sinopsis)s, director = %(director)s, fecha_actualizacion = NOW()
            WHERE id_pelicula = %(id_pelicula)s;
        """
        return connectToMySQL(DATABASE).query_db(query, data)

    @classmethod
    def obtener_por_id(cls, id_pelicula): # 4 Metodo para obtener una pelicula por id
        
        query = """
            SELECT v.*, u.nombre as organizador
            FROM peliculas v
            JOIN usuarios u ON v.id_organizador = u.id_usuario
            WHERE v.id_pelicula = %(id_pelicula)s;
        """
        data = {'id_pelicula': id_pelicula} 
        results = connectToMySQL(DATABASE).query_db(query, data)
        return cls(results[0]) if results else None

    @classmethod
    def eliminar(cls, id_pelicula): # 5 Metodo para eliminar una pelicula
        query1 = "DELETE FROM comentarios_pelicula WHERE id_pelicula = %(id_pelicula)s;"
        query2 = "DELETE FROM peliculas WHERE id_pelicula = %(id_pelicula)s;"
        data = {'id_pelicula': id_pelicula}
        connectToMySQL(DATABASE).query_db(query1, data)
        connectToMySQL(DATABASE).query_db(query2, data)
        return True

    @classmethod
    def obtener_por_organizador(cls, id_organizador): # 6 Metodo para obtener las peliculas de un organizador
        query = """
            SELECT v.*, u.nombre as organizador
            FROM peliculas v
            JOIN usuarios u ON v.id_organizador = u.id_usuario
            WHERE v.id_organizador = %(id_organizador)s;
        """
        data = {'id_organizador': id_organizador} 
        results = connectToMySQL(DATABASE).query_db(query, data)
        peliculas = [] 
        if results:
            for row in results:
                peliculas.append(cls(row))
        return peliculas

    @staticmethod
    def validar_pelicula(data): # 7 Metodo para validar una pelicula 
        errores = []
        if not data['nombre']:
            errores.append("el nombre es obligatoria")
        
        if len(data['nombre']) < 3:
            errores.append("El nombre debe tener al menos 3 caracteres")
        
        if 'id_pelicula' in data:
            query = """
                SELECT * FROM peliculas 
                WHERE nombre = %(nombre)s 
                AND id_pelicula != %(id_pelicula)s;
                """    
        else:
        
            query = """
                SELECT * FROM peliculas 
                WHERE nombre = %(nombre)s;
                """
        results = connectToMySQL(DATABASE).query_db(query, data)
        if results:
            errores.append("El nombre de la pelicula ya está en uso")

        if not data['fecha_estreno']:
            errores.append("la fecha de estreno es obligatoria")
        
        if not data['director']:
            errores.append("el director es obligatorio")

        if len(data['director']) < 3:
            errores.append("El director debe tener al menos 3 caracteres")

        if not data['sinopsis']:
            errores.append("la sinopsis es obligatoria")

        if len(data['sinopsis']) < 3:
            errores.append("La sinopsis debe tener al menos 3 caracteres")

        return errores

    
    
    
    
    
    