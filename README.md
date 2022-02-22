# Tic-Tac-Toe

## Table of contents

- [General info](#general-info)
- [Technologies](#tenchnologies)
- [Setup](#setup)
- [Screenshot](#screenshot)

## General info

Clone of a popular application Discord. Project created for educational purposes. Application includes following functionalities:
- User authentication with devise gem
- Management of created discord servers and channels
- Exploring and joining servers
- Every channel has its own group chat for server members
- Sending messages via turbo_streams for live creating, updating and removing

## Live Demo

https://disclone-live.herokuapp.com/

## Technologies

Project is created with:

- Rails 7.0.1
- PostgreSQL 14.0
- Tailwind

## Local installation

To run this project

- Prerequisites: Rails, Git, PostgreSQL
- Clone this repo
- Navigate into this project's directory cd `discord-clone` 
- Install the required gems `bundle install`
- Create database, by running `rails db:create`
- Migrate the database, by running `rails db:migrate`
- Start the local server, by running `rails server`
- Start redis server `redis-server`
- View `localhost:3000` in a web browser
