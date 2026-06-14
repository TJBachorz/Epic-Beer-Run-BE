# Dependency Upgrades & Render Deployment Design

**Date:** 2026-06-14
**Branch:** v2/dependency-upgrades

## Overview

Upgrade Epic Beer Run BE from Ruby 2.6.1 / Rails 6.0.3 to Ruby 3.3.6 / Rails 7.2, update all gems accordingly, and deploy to Render (free tier) as a replacement for the expired Heroku deployment.

## Section 1: Dependency Changes

### Ruby
- `.ruby-version`: `ruby-2.6.1` → `ruby-3.3.6`
- `Gemfile` ruby declaration: `'2.6.1'` → `'3.3.6'`

### Rails
- `rails '~> 6.0.3', '>= 6.0.3.4'` → `rails '~> 7.2'`

### Gems — updated
| Gem | From | To |
|-----|------|----|
| `puma` | `~> 4.1` | `~> 6.4` |
| `pg` | `>= 0.18, < 2.0` | `~> 1.5` |
| `bootsnap` | `>= 1.4.2` | latest compatible |
| `rack-cors` | unversioned | latest compatible |
| `rest-client` | unversioned | latest compatible |

### Gems — removed
| Gem | Reason |
|-----|--------|
| `json` | Ruby stdlib, not needed in Gemfile |
| `spring` | Removed in Rails 7.1+ |
| `spring-watcher-listen` | Removed with spring |
| `listen` | No longer needed in Rails 7 |
| `byebug` | Replaced by Ruby 3's built-in `debug` gem |

### Gems — added
| Gem | Group | Reason |
|-----|-------|--------|
| `debug` | development, test | Standard Ruby 3 debugger, replaces byebug |

## Section 2: Code Changes

### config/application.rb
- Bump `config.load_defaults 6.0` → `config.load_defaults 7.2`
- This enables Rails 7.2 framework defaults (e.g., new ActiveRecord defaults, encrypted cookies)

### config/initializers/cors.rb
- Verify rack-cors initializer exists and is correctly configured for the API
- If missing, create it with permissive config for development and restrict to known frontend origin in production

### config/puma.rb
- No changes required — already env-var driven (`PORT`, `RAILS_MAX_THREADS`, `RAILS_ENV`), which is what Render expects

### Application code (app/)
- No changes required — the controllers and model are too simple to be affected by Ruby 3 keyword argument changes or Rails 7 breaking changes

## Section 3: Render Deployment

### Files to add

**`Procfile`**
```
web: bundle exec puma -C config/puma.rb
```

**`bin/render-build.sh`** (executable)
```sh
#!/usr/bin/env bash
set -o errexit
bundle install
bundle exec rails db:migrate
```

**`render.yaml`** (infrastructure-as-code)
Declares the web service and PostgreSQL database so the app can be deployed from the repo. Key fields:
- Service type: `web`
- Environment: `ruby`
- Build command: `bin/render-build.sh`
- Start command: `bundle exec puma -C config/puma.rb`
- Attached database: `postgres` (free tier)

### Environment variables required on Render
| Variable | Source |
|----------|--------|
| `DATABASE_URL` | Auto-set by Render when Postgres DB is attached |
| `RAILS_MASTER_KEY` | Set manually from `config/master.key` |
| `RAILS_ENV` | Set to `production` |

### Deployment steps (post-code)
1. Push branch to GitHub
2. Create new Web Service on Render, connect to repo
3. Render detects `render.yaml` and pre-fills config
4. Add `RAILS_MASTER_KEY` env var manually
5. Deploy — Render runs `bin/render-build.sh` then starts Puma

## Out of Scope
- Frontend changes (separate repo)
- Test suite additions
- Feature changes to the API
