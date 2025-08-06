IMAGE_NAME="node-devops-app:1.0"
CONTAINER_NAME="node-devops-container"
PORT=8080

echo "Verificando la instalacion de Docker"
if ! command -v docker &> /dev/null; then
    echo "Error: Docker no esta instalado o no esta en el PATH."
    exit 1
fi
echo "Docker está instalado"

echo "Construyendo imagen de Docker"
docker build -t $IMAGE_NAME .
if [ $? -ne 0 ]; then
    echo "Error: Fallo la construcción de la imagen"
    exit 1
fi
echo "Imagen construida: $IMAGE_NAME"

echo "Eliminando contenedor anterior (si existe ese)"
docker rm -f $CONTAINER_NAME &> /dev/null

echo "Ejecutando nuevo contenedor creado"
docker run -d \
  -p $PORT:$PORT \
  --name $CONTAINER_NAME \
  -e PORT=$PORT \
  -e NODE_ENV=production \
  $IMAGE_NAME

if [ $? -ne 0 ]; then
    echo "Error: No se pudo iniciar el contenedor"
    exit 1
fi
echo "Contenedor iniciado: $CONTAINER_NAME"

echo "Esperando 5 segundos para que la aplicación inicie..."
sleep 5

echo "Probando el endpoint /health"
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT/health)

if [ "$RESPONSE" == "200" ]; then
    echo "Prueba exitosa: la aplicación responde correctamente en /health"
    echo "Aplicación disponible en: http://localhost:$PORT/"
else
    echo "Error: La aplicación no respondió correctamente (Código HTTP: $RESPONSE)"
    exit 1
fi

echo "Proceso se termino exitosamente"
