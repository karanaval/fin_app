# README

## Description
Educational project for Ruby&RoR course\
https://fin-app.fly.dev/

## Start project
```sh
bundle install
rails db:migrate RAILS_ENV=development # for the first launch
rails db:seed
rails s
```
## Tests
run all tests:\
`rails test -v`

run one test:\
`rails test test\<subfolder>\<test_name>`
