# Puppet manifest to configure Nginx with custom HTTP response header
# Configures a brand new Ubuntu machine with Nginx and X-Served-By header

# Update package list
exec { 'update_packages':
  command => '/usr/bin/apt-get update',
  path    => ['/usr/bin', '/bin'],
}

# Install Nginx package
package { 'nginx':
  ensure  => installed,
  require => Exec['update_packages'],
}

# Create Hello World index page
file { '/var/www/html/index.html':
  ensure  => file,
  content => "Hello World!\n",
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  require => Package['nginx'],
}

# Configure Nginx with custom HTTP header
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => "server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    server_name _;

    add_header X-Served-By ${facts['hostname']};

    location / {
        try_files \$uri \$uri/ =404;
    }
}",
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => [Package['nginx'], File['/etc/nginx/sites-available/default']],
}
