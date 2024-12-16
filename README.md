# CinePedia - Aplicación Web de Películas

**CinePedia** es una aplicación web desarrollada con **Flask** que permite a los usuarios consultar información sobre películas, ver comentarios de otros usuarios, y participar mediante la creación de nuevos comentarios. La aplicación está diseñada para ser una plataforma interactiva, donde los usuarios pueden ver películas organizadas por un administrador y dejar sus opiniones.

## Funcionalidades

### Gestión de Películas
Los usuarios pueden ver todas las películas disponibles, con información detallada como el nombre, fecha de estreno, director y sinopsis. Los administradores pueden agregar, editar y eliminar películas de la base de datos.

- **Ver película:** Los usuarios pueden ver la película seleccionada, así como toda su información y comentarios.
- **Agregar, editar o eliminar películas:** Los administradores tienen la capacidad de gestionar las películas disponibles en el sistema.

### Comentarios de Películas
Los usuarios pueden dejar comentarios sobre las películas que han seleccionado en ver. Además, los comentarios se visualizan con la información del usuario que los escribió.

- **Ver comentarios:** Los usuarios pueden leer todos los comentarios relacionados con una película.
- **Dejar comentarios:** Los usuarios pueden agregar sus propios comentarios sobre las películas.
- **Eliminar comentarios:** Los usuarios pueden eliminar sus propios comentarios si lo desean.

### Gestión de Usuarios
La aplicación permite que los usuarios se registren y creen una cuenta para poder interactuar con el sistema.

- **Registro de usuario:** Los nuevos usuarios pueden registrarse proporcionando su nombre, apellido, correo electrónico y una contraseña segura.
- **Validación de usuario:** La aplicación verifica que los usuarios proporcionen información válida, como un correo electrónico válido y contraseñas seguras.

### Enlace al Proyecto en Vivo
La aplicación está desplegada en un servidor EC2 de AWS y se puede acceder al siguiente enlace:

[**CinePedia en Vivo**](http://18.216.242.72/)

## Tecnologías Utilizadas

- **Flask:** Framework web para Python utilizado para desarrollar la aplicación.
- **MySQL:** Base de datos relacional para almacenar la información de las películas, usuarios y comentarios.
- **HTML/CSS:** Tecnologías de frontend utilizadas para crear la interfaz de usuario.
- **AWS EC2:** Se utiliza para desplegar la aplicación en la nube, utilizando un servidor basado en Ubuntu.

## Estructura del Proyecto

### Controladores

- **comentarios.py:** Controlador encargado de gestionar las operaciones relacionadas con los comentarios, como la creación, eliminación y visualización de comentarios por película.
- **peliculas.py:** Controlador encargado de manejar las operaciones relacionadas con las películas, como la creación, obtención y eliminación de registros de películas.
- **usuarios.py:** Controlador que gestiona la autenticación de usuarios, validación de datos y el registro de nuevos usuarios en el sistema.

### Modelos

- **Comentario.py:** 
  - Gestiona las operaciones con la tabla de comentarios en la base de datos.
  - Contiene métodos para crear, obtener, y eliminar comentarios, así como obtener comentarios por película.
  - **Métodos principales:**
    - `crear()`: Crea un nuevo comentario.
    - `obtener_por_pelicula()`: Obtiene todos los comentarios de una película específica.
    - `eliminar()`: Elimina un comentario específico.
    - `obtener_por_id()`: Obtiene un comentario por su ID.

- **Pelicula.py:** 
  - Gestiona las operaciones con la tabla de películas en la base de datos.
  - Permite agregar, editar, obtener y eliminar películas.
  - **Métodos principales:**
    - `get_all()`: Obtiene todas las películas.
    - `crear()`: Crea una nueva película.
    - `actualizar()`: Actualiza los detalles de una película.
    - `obtener_por_id()`: Obtiene una película por su ID.
    - `eliminar()`: Elimina una película.
    - `obtener_por_organizador()`: Obtiene todas las películas de un organizador.

- **Usuario.py:** 
  - Gestiona las operaciones relacionadas con los usuarios en la base de datos.
  - Permite registrar, autenticar y validar a los usuarios.
  - **Métodos principales:**
    - `get_all()`: Obtiene todos los usuarios.
    - `save()`: Guarda un nuevo usuario en la base de datos.
    - `get_by_email()`: Obtiene un usuario por su correo electrónico.
    - `get_by_id()`: Obtiene un usuario por su ID.
    - `validar_usuario()`: Valida los datos del usuario, incluyendo nombre, correo electrónico y contraseña.

### Base de Datos

- **Script de base de datos:** Se incluye el script de creación de las tablas necesarias para las películas, comentarios y usuarios.
- **ERD (Diagrama de Entidad-Relación):** El diagrama visualiza la estructura de las tablas y las relaciones entre ellas.

### Plantillas (HTML)

- **dashboard.html:** Vista que muestra el panel de control de los administradores y usuarios con las películas disponibles.
- **index.html:** Página principal de la aplicación donde los usuarios pueden registrarse o iniciar sesión.
- **editar_pelicula.html:** Plantilla para editar los detalles de una película existente.
- **nuevo.html:** Plantilla para agregar una nueva película al sistema.
- **ver_pelicula.html:** Plantilla para ver los detalles de una película y los comentarios de los usuarios.

### Archivos adicionales

- **`__init__.py`**: Inicializa la aplicación Flask y las configuraciones necesarias.
- **server.py**: Archivo principal que ejecuta el servidor de la aplicación Flask.

## ¿Cómo Funciona la Aplicación?

1. **Inicio de sesión/Registro:** La aplicación comienza en la página principal (`index.html`), donde los usuarios pueden registrarse o iniciar sesión con sus credenciales.
   
2. **Dashboard:** Una vez que el usuario ha iniciado sesión correctamente, se redirige al **dashboard** donde se le muestra la lista de películas disponibles. Si el usuario es un administrador, tiene la capacidad de agregar, editar o eliminar películas.

3. **Ver Detalles de la Película:** Al hacer clic en una película, los usuarios pueden ver la información detallada sobre la película seleccionada, incluyendo su nombre, sinopsis, director y los comentarios de otros usuarios.

4. **Agregar Comentarios:** Los usuarios registrados pueden escribir y agregar comentarios sobre las películas que han visto. Los comentarios se ordenan por fecha de creación. El usuario o administrador creador no puede agregar en su propia publicación un comentario.

5. **Administración de Películas:** Los administradores tienen la capacidad de agregar nuevas películas, actualizar la información de las existentes o eliminarlas(Solo puede editar o eliminar las propias). Esto se realiza a través de las plantillas `nuevo.html`, `editar_pelicula.html`, y el backend gestionado por el controlador `peliculas.py`.

6. **Eliminación de Comentarios:** Los usuarios pueden eliminar sus propios comentarios si lo desean a través de la interfaz de la película.

---

**Nota:** Si deseas realizar alguna modificación o agregar una funcionalidad, puedes hacerlo accediendo al código fuente de este repositorio en GitHub.



