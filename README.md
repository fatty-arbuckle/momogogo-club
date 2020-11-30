# Momogogo

## Running locally

1. Get the dependencies, `mix deps.get`
2. Compile the code, `mix compile`
3. Start the database, `docker-compose -f docker-compose-dev.yml up`
4. Create/migrate the database, `mix ecto.setup`
5. Run the server, `mix phx.server`
6. Connect, `http://localhost:4000`

### Import example data

1. Run the server with iex, `iex -S mix phx.server`
2. Import the data generation code, `import_file("test/gen_data.exs")`
3. Insert the data, `Data.Helper.create_test_data`


## Todo

* Chat
* invitations required for signup (ie, remove registration link)
* pagination on activities
* Dashboard graphs for activities
* "Success" of user edit always leaves you on edit
* "Cancel" of user edit always takes you dashboard
* Deleting an activity requires a refresh to see it removed

# Notes

- Yellow  #ffd545
- Purple  #fe4eb8

## References

https://www.pehp.org/mango/pdf/pehp/pdc/step%20conversion%20chart_FFB805BB.pdf
https://www.phoenixframework.org/blog/build-a-real-time-twitter-clone-in-15-minutes-with-live-view-and-phoenix-1-5
https://github.com/danschultzer/pow
https://www.youtube.com/watch?v=hnD0Z0LGMIk
https://info.crunchydata.com/blog/ssl-certificate-authentication-postgresql-docker-containers
https://experimentingwithcode.com/customizing-pow/
https://elixirforum.com/t/how-to-add-custom-additional-fields-to-users-table-with-pow/33849/2
