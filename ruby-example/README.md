# Validate Incoming calls to signalwire before answring them 

This is an example application that you can use to Answer or reject call after validaing From number with  [RoboKiller  API](https://enterprise-api.robokiller.com/v1/docs/).


## Running the app
You'll need the following to run the app:

* [Ruby](https://www.ruby-lang.org/en/downloads/)
* [Bundler](https://bundler.io/) for installing dependencies

Then clone the application:

```bash
git clone git@github.com:briankwest/robokiller.git
cd ruby-example
```

Install the dependencies:

```bash
bundle install
```

Execute setup.sh to configure create and congfigure 'config/env.yml
```bash
bash setup.sh
```

Start the application:

```bash
bundle exec rackup config.ru -p 3000 -o 0.0.0.0
```

Configure  [IP:3000/new_call](http://IP:3000/new_call) to your signalwire number LaML webhook and make call to that number to test

