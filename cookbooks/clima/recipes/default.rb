#
# Cookbook:: clima
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.
# Instala Python3 
package 'python3'
package 'python3-pip'

# Instala la librería requests (usada para consultar la API)
execute 'instalar_requests' do
  command 'pip3 install requests'
  not_if 'pip3 show requests'
end

# Crea el script de clima
file '/home/chars/chef/cookbooks/clima.py' do
  content <<-EOF
import requests

API_KEY = "2194d50f5339551c7b970c07dee54a31"
CIUDAD = "Ciudad de Mexico"
URL = f"http://api.openweathermap.org/data/2.5/weather?q={CIUDAD}&appid={API_KEY}&units=metric&lang=es"

respuesta = requests.get(URL)
datos = respuesta.json()

if respuesta.status_code == 200:
    clima = datos['weather'][0]['description']
    temp = datos['main']['temp']
    print(f"Clima en {CIUDAD}: {clima}, {temp}°C")
else:
    print("Error al obtener el clima:", datos)
  EOF
  mode '0755'
  owner 'chars'
  group 'chars'
end
