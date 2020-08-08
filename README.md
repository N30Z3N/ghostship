# GhostShip

GhostShip is a toolkit to build and deploy an ephemeral desktop environment which has a single web-browser only.  
It enables you to browse something securely.

![Screenshot](https://github.com/qb0C80aE/ghostship/raw/master/image.png)

## Requirements

You need a Heroku account, even free-tier one is enough.  
You also need Docker to build containers.

## If your PC does not have Docker and Heroku CLI

You can also build and deploy this GhostShip to Heroku using GitHub Actions.  
GitHub Actions supports both Docker and Heroku.

## How to use

First, you need to log in to your Heroku account.

```
$ heroku login --noninteractive
```

Second, create an Heroku app.

```
$ heroku create <appname>
```

After creating the app, set the environment variables below to your app.

|Name|Explanation|
|:-|:-|
|VNC_PASSWORD|Your VNC password. The letters after eighth will be ignored.|
|SCREEN_WIDTH|The width of the VNC screen.|
|SCREEN_HEIGHT|The height of the VNC screen.|

Here is an example.

```
$ heroku config:set -a <appname> VNC_PASSWORD=P@ssw0rd
$ heroku config:set -a <appname> SCREEN_WIDTH=1920
$ heroku config:set -a <appname> SCREEN_HEIGHT=1080
```

Then, clone this repo, build, and deploy.

```
$ git clone https://github.com/qb0C80aE/ghostship.git
$ cd ghostship
$ heroku container:login
$ heroku container:push -a <appname> web
$ heroku container:release -a <appname> web
```

Now it's time to enjoy.  
Let's access ``https://<appname>.herokuapp.com/vnc.html?autoconnect=1&reconnect=1&resize=scale&password=<Your VNC password>``

## For Japanese users

You can input Hiragana, Katakana, and Kanji by hitting Ctrl+Space.

## Limitations

Heroku's free tier has some limitations like file descriptor limitation, or stuff like that.  
Putting enough money into your Heroku account might resolve these.

Even if your Heroku account is the free-tier one, as long as you are opening the noVNC tab, the environment will continue to exist because GhostShip has a keep-alive function.

