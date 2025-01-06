# Usa una imagen base de Node.js para construir la aplicación
FROM node:16 AS builder

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos del proyecto Angular
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto del código fuente
COPY . .

# Construye la aplicación Angular
RUN npm run build --prod

# Usa una imagen base de Nginx para servir la aplicación
FROM nginx:alpine

# Copia los archivos generados por Angular al directorio de Nginx
COPY --from=builder /app/dist/oziclouds /usr/share/nginx/html

# Expone el puerto 80
EXPOSE 80

# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
