# Momogogo

## Running locally

1. Get the dependencies, `mix deps.get`
2. Compile the code, `mix compile`
3. Start the database, `docker-compose -f docker-compose-dev.yml up`
4. Create/migrate the database, `mix ecto.setup`
5. Run the server, `mix phx.server`
6. Connect, `http://localhost:4000`
2.  

## Todo

* Show placeholder for days with no activities
* Dashboard filters by time (Day, Week, Month, Year)
* Dashboard graphs for activities

# Notes

- Yellow  #ffd545
- Purple  #fe4eb8

## References

https://www.pehp.org/mango/pdf/pehp/pdc/step%20conversion%20chart_FFB805BB.pdf
https://www.phoenixframework.org/blog/build-a-real-time-twitter-clone-in-15-minutes-with-live-view-and-phoenix-1-5
https://github.com/danschultzer/pow
https://www.youtube.com/watch?v=hnD0Z0LGMIk
https://info.crunchydata.com/blog/ssl-certificate-authentication-postgresql-docker-containers
