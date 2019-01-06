# Dyno

Backend services to manage content, users, requests from mobile apps

## Getting Started

### Prerequisites

Redis is needed by Sideqik, PostgreSQL is the main database. They can be installed with the following:

```
brew install postgresql
brew install redis
```

Databases for dev and test can be created with:

```
rails db:create:all
```

### Installing

```
bundle install
```

## Running the server
The server itself can be run with `rails server`.
Although, to also execute the process that handles background jobs, run `foreman start` (it uses the Procfile to know what processes to start).

## Running the specs

Specs are running using Rspec, FactoryBot (ex FactoryGirl). Run all the specs with:

```
rspec
```

Run only one with


```
rspec spec/path/to/file_spec.rb
```


## Coding styles

Rubocop is used for linting the project. It runs with:

```
rubocop
```

## Deployment

TBD

Maybe with [Dokku](http://dokku.viewdocs.io/dokku/)

## Built With

* [Rails](http://www.dropwizard.io/1.0.2/docs/) - Framework
* [PostgreSQL](https://maven.apache.org/) - Database


## Versioning

[SemVer](http://semver.org/) is used for versioning.

