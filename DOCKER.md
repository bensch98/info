# Docker

## Clean up

Clean up all docker containers:

```bash
docker ps --all -q | xargs docker stop | xargs docker rm
```

