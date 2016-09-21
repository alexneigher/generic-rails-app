## Generic Rails App

A really basic, minimalist Rails app for experimenting with different search technologies and techniques.

### Setup

```
# Clone the project:
git clone git@github.com:omc/generic-rails-app.git

# Install the gems
bundle install

# Precompile the assets
rake assets:precompile

# Create the database
rake db:create
rake db:migrate
rake db:seed

# Run the app
rails s
```
