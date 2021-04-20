# actions-runners-config
Configurations for our self-hosted Github Actions runners

## `PDP` Runner

A few changes will need to be applied before upping an instance:
1. Add passwords to connection strings in [`pdp.env`](https://github.com/pacificclimate/actions-runner-config/blob/i1-add-pdp-runner-config/runners/pdp/pdp.env#L1)
1. Add repo token into [`docker-compose.yml`](https://github.com/pacificclimate/actions-runner-config/blob/i1-add-pdp-runner-config/runners/pdp/docker-compose.yml#L11)

From there you can use regular docker-compose commands:
```
$ docker-compose up -d
$ docker-compose down
```
