# 0x0B. SSH - Project Technical Documentation

This document provides a technical overview of the scripts and configuration files created for the "0x0B. SSH" project. Each section details the implementation and purpose of the corresponding task.

---

## Task 0: Use a Private Key

### **File: `0-use_a_private_key`**

This Bash script facilitates an SSH connection to a remote server using a specified private key.

#### **Implementation:**
```bash
#!/usr/bin/env bash
# Connects to a server using a specific private key

ssh -i ~/.ssh/school ubuntu@$1
```

-   **`ssh`**: The command-line tool for secure remote connections.
-   **`-i ~/.ssh/school`**: The `-i` flag specifies the identity file (private key) to be used for authentication. In this case, it is the `school` key located in the user's `.ssh` directory.
-   **`ubuntu@$1`**: Specifies the user (`ubuntu`) and the target host. The host is passed as the first command-line argument (`$1`) to the script.

---

## Task 1: Create an SSH Key Pair

### **File: `1-create_ssh_key_pair`**

This script automates the generation of a 4096-bit RSA SSH key pair.

#### **Implementation:**
```bash
#!/usr/bin/env bash
# Creates a 4096-bit RSA key pair with a passphrase

ssh-keygen -t rsa -b 4096 -f ./school -N "betty"
```

-   **`ssh-keygen`**: The standard tool for creating new SSH keys.
-   **`-t rsa`**: Specifies the key type to be RSA.
-   **`-b 4096`**: Sets the key length to 4096 bits for strong security.
-   **`-f ./school`**: Defines the base name for the output key files (`school` for the private key and `school.pub` for the public key) in the current directory.
-   **`-N "betty"`**: Sets a non-interactive passphrase ("betty") for the private key.

---

## Task 2: Client Configuration File

### **File: `2-ssh_config`**

This file contains SSH client-side configurations to streamline connections by setting default behaviors.

#### **Implementation:**
```
# Default SSH client configurations
Host *
    IdentityFile ~/.ssh/school
    PasswordAuthentication no
```

When this content is placed in `~/.ssh/config`, it instructs the SSH client to:
-   **`Host *`**: Apply the following rules to all hosts.
-   **`IdentityFile ~/.ssh/school`**: Automatically use the `~/.ssh/school` private key for authentication attempts.
-   **`PasswordAuthentication no`**: Disable password-based authentication, enforcing the more secure key-based method.

---

## Task 3: Add Public Key to Server

This task involves granting access to a server by adding a new public key to the list of authorized keys. This is performed directly on the server.

#### **Implementation:**

To authorize a new user or client, their public SSH key must be appended to the `~/.ssh/authorized_keys` file for the target user account on the server.

```bash
# Command to run on the server as the 'ubuntu' user
echo "ssh-rsa AAAAB3NzaC1yc2EAAA..." >> ~/.ssh/authorized_keys
```

-   This command appends the provided public key string to the `authorized_keys` file. Any client possessing the corresponding private key will now be able to authenticate as the `ubuntu` user without a password.
-   **Security Note:** For SSH key authentication to work, file permissions must be set correctly. The `~/.ssh` directory should have `700` permissions, and the `authorized_keys` file should have `600` permissions.

---

## Task 4: Client Configuration with Puppet

### **File: `100-puppet_ssh_config.pp`**

This Puppet manifest automates the configuration of the system-wide SSH client file (`/etc/ssh/ssh_config`) using declarative resources.

#### **Implementation:**
```puppet
# Puppet manifest to configure the SSH client

file_line { 'Turn off passwd auth':
  ensure => present,
  path   => '/etc/ssh/ssh_config',
  line   => '    PasswordAuthentication no',
  match  => '^\\s*#?\\s*PasswordAuthentication\\s+yes',
}

file_line { 'Declare identity file':
  ensure => present,
  path   => '/etc/ssh/ssh_config',
  line   => '    IdentityFile ~/.ssh/school',
  after  => '^\\s*Host \\*',
}
```

-   **`file_line` resource**: This resource type ensures that a specific line is present in a file.
-   **`Turn off passwd auth`**: This resource ensures the line `PasswordAuthentication no` exists. The `match` parameter uses a regular expression to find and replace the default setting, whether it is active or commented out.
-   **`Declare identity file`**: This resource adds the line `IdentityFile ~/.ssh/school` immediately after the `Host *` declaration, making it the default identity file for all connections.
-   This manifest can be applied using the command `sudo puppet apply 100-puppet_ssh_config.pp` to enforce the configuration idempotently. 