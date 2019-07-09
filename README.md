# Run Instructions

## Description
Challenge accepted: Your mission, should you choose to accept it, is to make a URL shortener API.

1. Clone this repository:

2. Run the following commands
```
bundle install
rake db:migrate db:setup db:seed
rails server
```

We use sidekit for background jobs to scrapp the title from each url, in order to work, you must install redis and start it with sidekiq:
```
brew install redis
redis-server
bundle exec sidekiq
```

## How it works?

Generate shortened urls and have a top 100 board with the most frequent accessed urls. After The Shorter is created a backgroundJob service is executed async that extracts the title from the url page and saved in to the database. 

you can check the demo working here:
[Shorty Url demo](https://shorty-url-challenge.herokuapp.com/)

## How to run specs
```
rspec
```