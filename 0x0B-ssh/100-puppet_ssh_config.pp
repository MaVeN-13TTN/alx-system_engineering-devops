# This Puppet manifest configures the SSH client to disable password
# authentication and use a specific private key.

file_line { 'Turn off passwd auth':
  ensure => present,
  path   => '/etc/ssh/ssh_config',
  line   => '    PasswordAuthentication no',
  match  => '^\s*#?\s*PasswordAuthentication\s+yes',
}

file_line { 'Declare identity file':
  ensure => present,
  path   => '/etc/ssh/ssh_config',
  line   => '    IdentityFile ~/.ssh/school',
  after  => '^\s*Host \*',
} 