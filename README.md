# Opensips

Role used to install opensips.

## Role Variables

Variables used to control role behavior.

|            variable            |                              description                              |      default value      |
| ------------------------------ | --------------------------------------------------------------------- | ----------------------- |
| opensips.version               | Version of OpenSIPS to be installed.                                  | 3.1                     |
| opensips.build                 | Release build of OpenSIPS to be used.                                 | releases                |
| opensips.modules               | List of OpenSIPS modules to be installed                              | `[]`                    |
| opensips.apt.repo              | Repository from which to retrieve installation files.                 | http://apt.opensips.org |
| opensips.apt.key.id            | GPG key id of apt repository                                          | 049AD65B                |
| opensips.apt.key.server        | GPG key server for import OpenSIPS repo keys                          | keyserver.ubuntu.com    |
| opensips.daemon.user           | User that will run OpenSIPS.                                          | opensips                |
| opensips.daemon.group          | Group that will run OpenSIPS.                                         | opensips                |
| opensips.daemon.memory.shared  | Amount of shared memory to allocate for the running OpenSIPS (in Mb)  | 64                      |
| opensips.daemon.memory.private | Amount of package memory to allocate for the running OpenSIPS (in Mb) | 32                      |
| opensips.daemon.options        | Any additional OpenSIPS daemon parameters                             | `-empty-`               |


## Example Playbook

Here is a small example of how to use this role:

```yml
- hosts: opensips
  roles:
    - role: opensips
      opensips:
        version: 3.1
        build: releases
        modules:
          - opensips-postgres-module
          - opensips-xmlrpc-module
        daemon:
          memory:
            shared: 64
            private: 32
          user: opensips
          group: opensips
        apt:
          repo: "http://apt.opensips.org"
          key:
            id: "049AD65B"
            server: keyserver.ubuntu.com
```

## Tests

The following stack of tools were used to test this role:

- [Kitchen CI](https://kitchen.ci/) for tests management.
- [Virtualbox](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com/) for provisioning environments.

### Steps

In `tests` folder, run the commands below:

```
bundle install          # Install tests stack dependencies.
kitchen create          # Create virtual machine to test playbook.
kitchen converge        # Apply test playbook in virtual machine.
kitchen verify          # Testing to your infrastructure.
```
