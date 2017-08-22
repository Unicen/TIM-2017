# TIM-2017
Este código corresponde a la cursada 2017 del Taller de Imágenes Médicas, válida como optativa de la carrera Ingeniería de Sistemas en la facultad de Ciencias Exactas de la UNICEN.

- [Instalación de git](#instalación)
- [Credenciales de nuestra computadora](#credenciales)
- [Creación de un nuevo repositorio](#nuevorepo) 
- [Clonar o actualizarnos respecto de un repositorio existente](#clonarrepo) 
- [Agregar, commitear y pushear](#addcommitpush)

# Instalación de git #

Entramos a [Git](https://git-scm.com/). Instalamos de acuerdo a nuestro sistema operativo. Nos hacemos una cuenta personal en [github](https://github.com) para subir las resoluciones de los prácticos.

# Credenciales de nuestra computadora #
Para simplificar varias cosas, debemos configurar nuestras credenciales de git locales. Para eso ejecutamos los siguientes comandos en la consola de git (cambiar los nombres de ejemplo por el nuestro):
- *git config --global user.name "Juan Nieve"*
- *git config --global user.email juanieve@winter.com*

# Creación de un nuevo repositorio #
Creamos un nuevo directorio, nos movemos hasta él y ejecutamos el comando *git init*

# Clonar un repositorio existente #
Si ya tenemos clonado un repositorio y solamente queremos actualizar nuestros datos locales, ejecutamos el comando *git pull origin master*.
Si queremos clonar un repositorio en un directorio nuevo, nos movemos hasta ese directorio y ejecutamos el comando *git clone https://github.com/Unicen/TIM-2017.git*.
En este caso se clona este repositorio, para clonar otro simplemente se cambia la dirección URL.

# Agregar, commitear y pushear #
