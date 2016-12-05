# Lottery

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

To import the test CSV, make sure the database is configured and do

    mix run import.exs

## API

To see a listing of all campaigns (persons excluded)

    curl http://localhost:4000/campaigns

To see full detail on a campaign (persons included)

    curl http://localhost:4000/campaign/1

To choose a person and mark them as chosen; person data is returned

    curl -d '' http://localhost:4000/choose/1

### Return Data & Errors

All responses are json objects. If anything goes wrong, expect a string in the `error` key.
