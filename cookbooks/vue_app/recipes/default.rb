#
# Cookbook:: vue_app
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.
#
# Cookbook:: vue_app
# Recipe:: default
#

# Instalar dependencias necesarias
package 'curl'

# Instalar Node.js y npm usando script oficial
bash 'install_nodejs' do
  code <<-EOH
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
    apt-get install -y nodejs
  EOH
  not_if 'which node'
end

# Instalar Vue CLI globalmente
execute 'install_vue_cli' do
  command 'npm install -g @vue/cli'
  not_if 'npm list -g @vue/cli'
end

# Crear directorio del proyecto
directory '/home/chars/vue-project' do
  owner 'chars'
  group 'chars'
  mode '0755'
  action :create
end

# Crear proyecto Vue si no existe
bash 'create_vue_project' do
  cwd '/home/chars'
  code <<-EOH
    vue create -d vue-project --force
  EOH
  not_if { ::File.exist?('/home/chars/vue-project/package.json') }
end

# Iniciar el servidor (solo ejemplo; para producción, usar un servicio como nginx)
bash 'run_vue_project' do
  cwd '/home/chars/vue-project'
  code <<-EOH
    npm install
    npm run serve &
  EOH
  environment({
    'HOME' => '/home/chars'
  })
  not_if 'lsof -i :8080'
end
