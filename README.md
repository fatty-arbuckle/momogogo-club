# Momogogo

## Manually running a release

```
docker run --name stub-postgres -e POSTGRES_USERNAME=postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 --rm postgres
```

```
MIX_ENV=prod mix deps.get
MIX_ENV=prod mix deps.compile
MIX_ENV=prod mix release
DATABASE_URL=ecto://postgres:postgres@localhost/momogogo_dev SECRET_KEY_BASE=$(mix phx.gen.secret) ./_build/prod/rel/momogogo/bin/momogogo eval "Momogogo.Release.migrate"
DATABASE_URL=ecto://postgres:postgres@localhost/momogogo_dev SECRET_KEY_BASE=$(mix phx.gen.secret) ./_build/prod/rel/momogogo/bin/momogogo start
```

## Running a release via Docker

## Todo

* secure db connection
* test deployment
* Show user's activity by week/month/etc
* Show all activity by week/month/etc by user

- Yellow  #ffd545
- Purple  #fe4eb8

# Notes

## Timeline

Contains `Post`s of activity

## References

https://www.pehp.org/mango/pdf/pehp/pdc/step%20conversion%20chart_FFB805BB.pdf
https://www.phoenixframework.org/blog/build-a-real-time-twitter-clone-in-15-minutes-with-live-view-and-phoenix-1-5
https://github.com/danschultzer/pow
https://www.youtube.com/watch?v=hnD0Z0LGMIk
https://info.crunchydata.com/blog/ssl-certificate-authentication-postgresql-docker-containers
