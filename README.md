# Leads Management System using Sinatra

## Description

This is a simple tracking system for leads(potential customers) of different sales agents. An agent has many leads, and a lead belongs to an agent. The leads have a status that needs to be updated from time to time by the agent, whether the lead is still pursuable - Go - , not pursuable - No Go - or already turned to a client - Converted -. Each agent belongs to a region, where other agents may possibly work in. Besides viewing his/her leads, an agent can see a detailed list of leads and their corresponding status in his/her region. The agent can also see an overview of how many agents, how many leads and their status in all regions listed in the database.

## Usage

To use this app, just clone, run rake db:migrate and then run shotgun


## Requirements Done

1. Build an MVC Sinatra Application.
2. Use ActiveRecord with Sinatra.
3. Use Multiple Models.
4. Use at least one `has_many` relationship on a User model and one `belongs_to` relationship on another model
5. Must have user accounts. The user that created a given piece of content should be the only person who can modify that content
6. Must have the abilty to create, read, update and destroy any instance of the resource that belongs to a user.
7. Ensure that any instance of the resource that belongs to a user can be edited or deleted only by that user.
8. Should also have validations for user input to ensure that bad data isn't added to the database. The fields in signup form are required and the user attribute that is used to login a user should be a unique value in the DB before creating the user.
