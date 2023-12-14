# Usa la imagen oficial de Grafana como base
FROM grafana/grafana:latest

# Copia tu configuración de Grafana si es necesario (por ejemplo, si tienes archivos de configuración personalizados)
# COPY /ruta/a/tu/configuración /etc/grafana

# El puerto en el que Grafana escuchará (puedes cambiarlo si es necesario)
EXPOSE 3000

# Comando para iniciar Grafana
CMD ["grafana-server", "--config=/etc/grafana/grafana.ini"]