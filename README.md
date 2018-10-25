# Drone-mina
> Inspired by [drone-capistrano](https://github.com/glaszig/drone-capistrano)

##  Usage
1. Generate SSH key for deploy
2. Put public SSH key to the server that you want to deploy
3. Set drone secret mina_private_key with private SSH key
```
drone secret add \
  --name mina_private_key \
  --value @$HOME/.ssh/deploy_rsa \
  --image uitk23009/drone-mina
  --repository octocat/hello-world

```
4. Set drone task
> This plugin would install [mina-multi_server](https://github.com/Juanmcuello/mina-multi_server) and [mina-multistage](https://github.com/endoze/mina-multistage)
> so you can use command ```mina production deploy```
> and ```set :servers, ['server-1.example.com', 'server-2.example.com']``` like capistrano
```
pipeline:
  deploy:
    image: uitk23009/drone-mina
    pull: true
    repo: octocat/hello-world
    mina_cmd:
        - mina production setup
        - mina production deploy
        - mina production deploy:force_unlock
    secrets: [ mina_private_key ]
    when:
      branch: master
```