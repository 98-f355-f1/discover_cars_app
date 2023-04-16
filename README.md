# An example Rails + Docker app

**This app is using Rails 7.0.4.3 and Ruby 3.2.2**.

## Table of contents

- [Tech stack](#tech-stack)
- [Running this app](#running-this-app)
- [Files of interest](#files-of-interest)
  - [`.env`](#env)
  - [`run`](#run)
- [Updating dependencies](#updating-dependencies)
- [Additional resources](#additional-resources)
  - [Learn more about Docker and Ruby on Rails](#learn-more-about-docker-and-ruby-on-rails)

## Tech stack


### Back-end

- [PostgreSQL](https://www.postgresql.org/)
- [ERB](https://guides.rubyonrails.org/layouts_and_rendering.html)

### Front-end

- [Hotwire Turbo](https://hotwired.dev/)
- [StimulusJS](https://stimulus.hotwired.dev/)
- [TailwindCSS](https://tailwindcss.com/)


## Running this app

You'll need to have [Docker installed](https://docs.docker.com/get-docker/).

You'll also need to enable Docker Compose v2 support if you're using Docker
Desktop. On native Linux without Docker Desktop you can [install it as a plugin
to Docker](https://docs.docker.com/compose/install/linux/). It's been generally
available for a while now and very stable. This project uses a specific Docker
Compose profiles feature that only works with Docker Compose v2.


#### Copy an example .env file because the real one is git ignored:

```sh
cp .env.example .env && rm -f .env.example
```

#### Build everything:

*The first time you run this it's going to take a few minutes depending on your
internet connection speed and computer's hardware specs. That's because it's
going to download a few Docker images and build the Ruby + Ngnix dependencies.*

```sh
docker-compose build && docker-compose up
```

Everything should be up and running, all tables, schema and data has been seeded, ready to go.


Now that everything is built and running we can treat it like any other Rails
app.

Did you receive an error about a port being in use? Chances are it's because
something on your machine is already running on port `3000`. Check out the docs
in the `.env` file for the `DOCKER_WEB_PORT` variable to fix this.

Did you receive a permission denied error? Chances are you're running native
Linux and your `uid:gid` aren't `1000:1000` (you can verify this by running
`id`). Check out the docs in the `.env` file to customize the `UID` and `GID`
variables to fix this.


#### Check it out in a browser:

Visit <http://localhost:3000> in your favorite browser.

#### Stopping everything:

```sh
# Stop the containers and remove a few Docker related resources associated to this project.
<CTRC + C>

or

docker-compose down
```

You can start things up again with `docker-compose up` and unlike the first
time it should only take seconds.

## Files of interest

### `.env`

This file is ignored from version control so it will never be commit. There's a
number of environment variables defined here that control certain options and
behavior of the application. Everything is documented there.

Feel free to add new variables as needed. This is where you should put all of
your secrets as well as configuration that might change depending on your
environment.

### `run`

You can run `./run` to get a list of commands and each command has
documentation in the `run` file itself.

It's a shell script that has a number of functions defined to help you interact
with this project.

For example as a shell script it allows us to pass any arguments to another
program.

This comes in handy to run various Docker commands because sometimes these
commands can be a bit long to type. Feel free to add as many convenience
functions as you want. This file's purpose is to make your experience better!

For example, to enter the Rails console
```sh
./run rails console or just c
```

In fact anything you can do within the Rails app in the bin folder is just
```sh
./run <cmd>

./run bundle install
./run rails generate ...
```

*If you get tired of typing `./run` you can always create a shell alias with
`alias run=./run` in your `~/.bash_aliases` or equivalent file. Then you'll be
able to run `run` instead of `./run`.*


## Updating dependencies

Let's say you've customized your app and it's time to make a change to your
`Gemfile` file.

Without Docker you'd normally run `bundle install`. With
Docker it's basically the same thing and since these commands are in our
`Dockerfile` we can get away with doing a `docker-compose build` but don't run
that just yet.

#### In development:

You can run `./run bundle:outdated` to get a list of
outdated dependencies based on what you currently have installed. Once you've
figured out what you want to update, go make those updates in your `Gemfile` file.

Then to update your dependencies you can run `./run bundle:install`. That'll make sure any lock files get copied from Docker's image
(thanks to volumes) into your code repo and now you can commit those files to
version control like usual.

Alternatively for updating your gems based on specific version ranges defined
in your `Gemfile` you can run `./run bundle:update` which will install the
latest versions of your gems and then write out a new lock file.

You can check out the `run` file to see what these commands do in more detail.

### Learn more about Docker and Ruby on Rails

#### Official documentation

- <https://docs.docker.com/>
- <https://guides.rubyonrails.org/>
