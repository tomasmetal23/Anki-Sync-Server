FROM python:3.10-slim-buster

# Definimos las variables de entorno en el formato que deseas
ENV SYNC_USER1=${SYNC_USER1}
ENV SYNC_HOST=${SYNC_HOST}
ENV SYNC_PORT=${SYNC_PORT}
ENV MAX_SYNC_PAYLOAD_MEGS=${MAX_SYNC_PAYLOAD_MEGS}

# Directorio donde se guardaran los datos de la aplicaicon en el contenedor
ENV SYNC_BASE=${SYNC_BASE}


# Exponer el puerto de sincronización
EXPOSE 27701

WORKDIR  /sync

RUN pip install anki

CMD ["sh", "-c", "python -m anki.syncserver --host=${SYNC_HOST} --port=${SYNC_PORT} --base=${SYNC_BASE} --user=${SYNC_USER1}"]
