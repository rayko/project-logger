# Project Logger

A simple project manager focused on a timeline view, for recording and tracking work done, through entries.

The motivation for this simple application was to systemize a little the way I tend to manage hobby projects, where I don't have tight time constraints or the need of metrics.

Hobby projects tend to be sparse in time, working on them when there is extra time to spend, rather than being strictly scheduled. In this context, it's easier to write some text about what was done, and where to continue from for the next time I continue it.

# Installation

Requires Ruby 3.2.2 installed via `RVM`, `rbenv` or else.

Some OS dependencies required:

```
$ sudo apt-get install postgresql-server-dev-all imagemagick
```

Standard Rails 7 procedure:

```
$ git clone <repo>
$ cd project-logger
$ bundle install
$ rake db:migrate
$ rails s
```


With docker:

```
$ docker build -t project-logger:latest .
$ docker run --rm -it --network=host project-logger:latest
```

The intended deployment option would be with `docker-compose`:

```
$ cd project-logger
$ mkdir docker-env
$ mkdir docker-env/storage
$ mkdir docker-env/postgres16
$ chmod 1000:1000 docker-env/storage
$ docker-compose run --rm web bundle exec rake db:migrate
$ docker-compose run --rm web project-logger create_user my@email.com mypass 'My Name'
$ docker-compose up -d
```

The above process boots up the app at `http://127.0.0.0.1:5000`. The `docker-compose.yml` uses `./docker-env` folder for PostgreSQL database data dir and `ActiveStorage` store. Note the `chmod` command above, this is required for the app to have proper permissions on this directory. During build, `Dockerfile` will create a user `rails` with ID `1000:1000`. When running through `docker-compose`, that user will be writing to `./docker-env/storage`, as long as IDs match, it should be fine.

The first `docker-compose run` command will migrate the database, while the second one, will run a small cli tool `project-logger` to create a user. There is no registration available on this app, so this is the way to boot up a user.

# Configurations

Via `.env` files. Copy the `env.sample` as `.env.development`,
`.env.production` or `.env.test`. For deployment with `docker-compose`,
place a `.env.production`.
