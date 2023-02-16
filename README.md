# Introduction
Application that allows registered users to track their money movements in different accounts.

Every account is associated to a currency.

The user can record credits and debits on his accounts as well as exchange money between them.

# Development

## New development environment
```
bundle config path <writable_path>
```

## Prepare Database

```
bundle exec rails db:create
bundle exec rails db:migrate
```


## Run application

```
bundle exec rails server
```


# Authentication
`https://hackernoon.com/using-devise-in-your-ruby-on-rails-application-a-step-by-step-guide-m92i3y5s`

To register a user: `http://localhost:3000/users/sign_up`

