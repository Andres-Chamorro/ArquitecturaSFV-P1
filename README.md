# ArquitecturaSFV-P1

# Evaluación Práctica - Ingeniería de Software V

## Información del Estudiante
- **Nombre: Ricardo Andres Chamorro Martinez**
- **Código: A00399846**
- **Fecha: 06/08/2025**

## Resumen de la Solución
Esta practica consiste en contenizar una aplicacion node.js utilizando Docker, hacer todo el proceso de creacion de imagen, crear un script automatizado para su despliegue y validacion, y aplicar principios DevOps para optimizar el flujo de desarrollo y operación

## Dockerfile
Algunas decisiones que tomé:

- Usé la imagen `node:18-alpine` porque es ligera y suficiente para la app, ademas fue de las unicas que encontre y las que mas se utilizan.
- Definí un directorio de trabajo `/usr/src/app` para mantener los archivos organizados dentro del entornl.
- Primero copié los archivos `package*.json` y luego instale las dependencias con `npm install --production` para que solo se instalen las necesarias en producción.
- Despues copie el resto del código.
- Coloque el puerto `3000` (aunque desde afuera se mapea al 8080).
- Finalmente, el contenedor ejecuta la app con `node app.js`.

## Script de Automatización
El script `deploy.sh` se creo manualmente desde el entorno de visual, creando primero el file y paso a paso su contenido:

1. Revisa si Docker está instalado.
2. Construye la imagen usando el Dockerfile.
3. Borra un contenedor anterior si existe (para evitar errores posteriores a la ejecucion).
4. Levanta un nuevo contenedor con las variables `PORT=8080` y `NODE_ENV=production`.
5. Espera unos segundos y hace una prueba al endpoint `/health` para confirmar que todo está funcionando.
6. Muestra un mensaje indicando si todo salió bien o no.
   
## Principios DevOps Aplicados
1. **Automatización**: Se evita hacer todo manualmente creando un script que hace el trabajo por mí.
2. **Consistencia**: Con Docker, la app corre igual en cualquier máquina, sin importar el sistema operativo.
3. **Pruebas rápidas:** El script valida automáticamente que la app esté funcionando.
4. **Entorno igual para todos:** Usar Docker asegura que la app corra igual en cualquier máquina.


## Captura de Pantalla
![Captura 1](./images/image%201%20%282%29.png)


## Mejoras Futuras
1. **Automatizar todo el proceso en la nube:**  
   Que la aplicación se despliegue sola cuando se actualice el código, sin tener que ejecutar comandos manualmente.

2. **Agregar una verificación automática de la salud del contenedor:**  
   Para saber si la aplicación sigue funcionando sin tener que probarla manualmente.

3. **Monitorear la aplicación:**  
   Tener una forma sencilla de revisar si la app está activa, ver errores y estadísticas.

4. **Hacer la imagen más liviana:**  
   Para que se descargue más rápido y use menos espacio.

5. **Incluir pruebas antes de desplegar:**  
   Que se ejecuten pruebas básicas para asegurarse de que todo esté bien antes de poner la app en marcha.

## Instrucciones para Ejecutar

1. **Clonar el proyecto o descargar los archivos**  
   Asegúrate de tener el código del proyecto en tu computadora.

2. **Instalar Docker**  
   Si no tienes Docker instalado, descárgalo desde [https://www.docker.com](https://www.docker.com) e instálalo.

3. **Construir la imagen de la aplicación**  
   Abre una terminal en la carpeta del proyecto y ejecuta:  
   ```bash
   docker build -t node-devops-app:1.0 .

4. **Ejecutar el contenedor manualmente**
Una vez construida la imagen, levanta el contenedor con:

```bash
docker run -d -p 8080:8080 --name node-devops-container \
-e PORT=8080 -e NODE_ENV=production node-devops-app:1.0

```

5. **Comprobar que la aplicación está funcionando**

Abre tu navegador o usa curl para probar:

- Página principal: http://localhost:8080/

- Endpoint de salud: http://localhost:8080/health

   


