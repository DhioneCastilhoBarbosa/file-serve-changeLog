# Nginx com WebDAV habilitado (vem no nginx:alpine)
FROM nginx:alpine

# Copia configs
COPY nginx/firmware.conf /etc/nginx/conf.d/firmware.conf
COPY nginx/htpasswd      /etc/nginx/.htpasswd

# Prepara diretório de dados e permissões
RUN mkdir -p /usr/share/nginx/html/firmware \
 && chown -R 101:101 /usr/share/nginx/html/firmware \
 && apk add --no-cache curl

EXPOSE 80

# Healthcheck simples
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -fsS http://localhost/firmware/ || exit 1

CMD ["nginx","-g","daemon off;"]
