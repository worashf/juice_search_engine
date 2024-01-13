# Juice Search Engine

Juice Search Engine is a real-time search box application that empowers users to search for articles and provides insightful analytics on user search behavior. This project focuses on capturing and analyzing search input in real-time, recording analytics per user, and displaying trends to showcase what users are searching for the most.

## Features

1. **Real-time Search:** Users can input search queries, and the system captures and logs every search instantly.

2. **User Tracking:** Search analytics are recorded per user, ensuring that each user's data is kept separate.

3. **Instant Search:** The search functionality is designed to be fast and responsive.

4. **Analytics & Trends:** The system generates analytics and trends based on user search behavior.

## Built With

### Technologies

- Ruby on Rails
- Postgres
- JavaScript
- HTML and Bootstrap

### Tools

- Docker

### Gems

- [pg-search](https://github.com/Casecommons/pg_search) - Enables efficient search capabilities in PostgreSQL.
- [faker](https://github.com/faker-ruby/faker) - A library for generating fake data for testing.
- [fuzzy-string-match](https://github.com/seamusabshere/fuzzy-string-match) - Provides fuzzy string matching algorithms.
- [will-paginate](https://github.com/mislav/will_paginate) - Handles pagination of search results.
- [bootstrap](https://getbootstrap.com/) - Front-end framework for building responsive web applications.

## Getting Started
### Prerequisites
To set up and run this project locally:
- Ruby
- Ruby on Rails
- PostgrSQL
- Docker
### Setup
#### Install

1. Clone or download this repository. [Juice search engine](https://github.com/worashf/juice_search_engine)
2. cd to the forlder
3. Run `docker-compose` to install the packages.
4. Run `docker-compose up`


#### Configure database
In the root folder of the project, run the following:
 1. `docker-compose run app rails db:create`
 2. `docker-compose run app rails db:migrate`
 3. `docker-compose run app rails db:seed`

 #### Configure test database
To run the tests, configure it first:
.1. `docker-compose run test rails db:create`
 2. `docker-compose run test rails db:migrate`

# Tests

To run unit and integration tests, execute the following command in the root project's directory:

1. `docker-compose run test`










