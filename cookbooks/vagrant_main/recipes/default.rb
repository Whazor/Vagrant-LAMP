require_recipe "apt"
require_recipe "git"
require_recipe "oh-my-zsh"
require_recipe "apache2"
require_recipe "apache2::mod_rewrite"
require_recipe "apache2::mod_ssl"
require_recipe "mysql::server"
require_recipe "php"
require_recipe "apache2::mod_php5"

# Install packages
%w{ debconf vim screen mc subversion curl tmux make g++ libsqlite3-dev php5-xdebug }.each do |a_package|
  package a_package
end

# Generate selfsigned ssl
execute "make-ssl-cert" do
  command "make-ssl-cert generate-default-snakeoil --force-overwrite"
  ignore_failure true
  action :nothing
end

apache_site "default" do
	enable true
end
web_app "localhost" do
	server_name "localhost"
	server_aliases ["localhost.dev"]
	docroot "/vagrant/"
end

# Add site info in /etc/hosts
bash "hosts" do
 code "echo 127.0.0.1 localhost >> /etc/hosts"
end

