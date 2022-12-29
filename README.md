### Setup job queue

This project is using `sidekiq` and `sidekiq-scheduler` to manage and schedule
background jobs. To use this you should only need to steps:

1. Install and run `redis` with default configuration
2. run `bundle exec sidekiq`

In producion or custom redis installations just use the `REDIS_URL` env variable.

The sidekiq **web ui** can be viewed on `/admin/sidekiq`.
