from flask_app.config.mysqlconnection import connectToMySQL
from datetime import datetime

DATABASE = 'cinePedia'

class Comentario:
    def __init__(self, data):
        self.id = data['id']
        self.contenido = data['contenido']
        self.fecha_creacion = data['fecha_creacion']
        self.usuario_id = data['usuario_id']
        self.pelicula_id = data['pelicula_id']
        self.usuario_nombre = data.get('usuario_nombre')

    @classmethod
    def crear(cls, data): # 1 Metodo para crear un comentario
        query = """
            INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, pelicula_id)
            VALUES (%(contenido)s, NOW(), %(usuario_id)s, %(pelicula_id)s);
        """
        return connectToMySQL(DATABASE).query_db(query, data)

    @classmethod
    def obtener_por_pelicula(cls, pelicula_id): # 2 Metodo para obtener todos los comentarios de una pelicula
        query = """
            SELECT c.*, u.nombre as usuario_nombre
            FROM comentarios c
            JOIN usuarios u ON c.usuario_id = u.id_usuario
            WHERE c.pelicula_id = %(pelicula_id)s
            ORDER BY c.fecha_creacion DESC;
        """
        data = {'pelicula_id': pelicula_id}
        results = connectToMySQL(DATABASE).query_db(query, data)
        comentarios = []
        if results:
            for row in results:
                comentarios.append(cls(row))
        return comentarios

    @classmethod
    def eliminar(cls, id): # 3 Metodo para eliminar un comentario
        query = "DELETE FROM comentarios WHERE id = %(id)s;"
        data = {'id': id}
        return connectToMySQL(DATABASE).query_db(query, data)
    
    
    @classmethod
    def obtener_por_id(cls, id): # 4 Metodo para obtener un comentario por id
        query = "SELECT * FROM comentarios WHERE id = %(id)s;"
        data = {'id': id}
        result = connectToMySQL(DATABASE).query_db(query, data)
        if result:
            return cls(result[0])
        return None