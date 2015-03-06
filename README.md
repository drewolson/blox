# Blox

[![Build Status](https://travis-ci.org/drewolson/blox.svg?branch=master)](https://travis-ci.org/drewolson/blox)

It's a blog?!

## Run it

```bash
mix do deps.get, db.reset
mix phoenix.server
```

## Test it

```bash
MIX_ENV=test mix db.reset
mix test
```

## Assumptions

Blox assumes you're running postgres locally on the default port and that your curernt user can create databases.
