# Acorn

[![Build Stage](https://img.shields.io/badge/build%20stage-WIP-yellow.svg)](https://open-idea-station-staging.herokuapp.com)
[![License](http://img.shields.io/badge/license-MIT-blue.svg?)](http://opensource.org/licenses/MIT)
[![Build Status](https://travis-ci.org/Open-Idea-Station/Acorn.svg?branch=develop)](https://travis-ci.org/Open-Idea-Station/Acorn)
[![Codeship Status for Open-Idea-Station/Acorn](https://codeship.com/projects/84ea22e0-286f-0136-d8bf-1e20b495677c/status?branch=develop)](https://www.codeship.io/projects/287138)
[![Maintainability](https://api.codeclimate.com/v1/badges/42077e04fa277934e430/maintainability)](https://codeclimate.com/github/Open-Idea-Station/Acorn/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/Open-Idea-Station/Acorn/badge.svg?branch=develop)](https://coveralls.io/github/Open-Idea-Station/Acorn?branch=develop)



## About
#### Acorn is the foundation on which Open Idea Station(an open source web application) is built. For more information visit [Open Idea Station](https://open-idea-station.herokuapp.com).

## Technology Stack
Acorn is written in:
  - Ruby on Rails Framework
  - PostgreSQL Database

## Authentication and Code Base Organization
  - Written in Ruby and uses JWT for authentication.  
  - Uses [Airbnb Ruby Style Guide](https://github.com/airbnb/ruby) for Code Organization

## Usage

#### Installation and Dependencies

1. Install [Ruby](https://www.ruby-lang.org). [v2.4.0] or higher `required`

2. Install [Rails](http://rubyonrails.org/). [v5.0.1] or higher `required`

3. Install [PostgreSQL](https://www.postgresql.org/download/) `required`

4. Install [RubyGems](https://rubygems.org/) and [Bundler](http://bundler.io/) to help you manage dependencies in your [Gemfile](Gemfile).

5. Clone the repo and cd into it

    ```
    git clone https://github.com/Open-Idea-Station/Acorn/.git
    cd Acorn
    ```

6. Install dependencies

    ```
    Run `bundle install` to install all required gems
    ```

6. Install dependencies

    ```
    Run `figaro install` to automatically generate `application.yml`
    file for setting environment variables
    ```
    
7. Configure database

    ```
    Open `config/application.yml` and add the following configuration:
    
    LOGIN_URL: ''
    LOGOUT_URL: ''
    ACORN_DB_USERNAME: 'postgres'
    ACORN_DB_PASSWORD: 'Andela'
    ACORN_HOST: 'localhost'
    ACORN_DB: 'acorn_db'
    ACORN_TEST_DB: 'acorn_test_db'
    TEST_URL: ''
    ```

8. Run database creation

    ```
    Run `rake db:setup`, to setup database using the provided
    configurations.
    ```

8. Run database migrations

    ```
    Run `rake db:migrate`, to perform migrations
    ```

9. Load and edit host configuration - local deploy for mac

    ```
    Run `sudo nano /etc/hosts`. 
    Edit the terminal and include `127.0.0.1   open-idea-station.io` to the list of hosts.
    Save changes and exit the terminal
    ```

8. Start the application

    ```
    Run `rails s`
    ```

8. Visit the application url

    ```
    go to: http://open-idea-station.io:3000
    ```
## Testing
- Run test with `rspec spec`

## Api Docs

## Contributing
Check the [contributing](contributing.md) file, it contains everything you need to know.

## Credits

## License
[MIT](https://github.com/Open-Idea-Station/Acorn/blob/develop/LICENSE)

## FAQ
#### Is this an Open-Source Application?


    Yes it is, and contributing to the development of this
    application is by raising PRs
    

#### Who can contribute?

    Anyone!. This application is open to all those who want to
    contribute to open-source development and are willing to follow
    set standards for contributing.
    
#### Is there a set standard for PRs to this repository?

    Yes, there are set conventions for PRs to this repository and can be found
    in the project wiki.
    
#### What language was used to develop this application?

    This project is a Ruby on Rails application
    
#### Can I clone this application for personal use?

    Yes!. This application is licensed under MIT, and is open for
    whatever you may choose to use it for.
    
