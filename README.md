# LMS + Recommendation Microservices (Rails + Sequent)

## TL;DR

```sh
docker compose up --build
# In another terminal, run the reco event consumer:
docker compose exec reco rails runner 'RedisEventConsumer.start'
```

## Overview
- **LMS**: CRUD for courses/lessons, progress tracking, user stats, event-sourcing (Sequent)
- **Recommendation**: Consumes events, recommends next course, event-sourcing (Sequent)
- **Async messaging**: Redis Streams for event propagation
- **Auth**: JWT (stubbed)

## Setup
1. Prerequisites: Docker, Docker Compose
2. `docker compose up --build`
3. In a separate terminal, start the reco event consumer:
   ```sh
   docker compose exec reco rails runner 'RedisEventConsumer.start'
   ```
4. Access:
   - LMS: http://localhost:3001
   - Recommendation: http://localhost:3002

## API Examples
See [`/docs/api.http`](docs/api.http) for HTTPie/curl examples.

## Event Contract
- LMS publishes events (e.g., `LessonCompletedEvent`) to Redis Stream `lms_events`.
- Reco consumes these events and projects them into its own event store.
- Event format: `{ event_type: 'LessonCompletedEvent', data: { ...event fields... } }`

## Testing
- RSpec: `docker compose exec lms rspec` or `docker compose exec reco rspec`
- Coverage: 90%+ on core domains

## Design Decisions
- CQRS/Event Sourcing with Sequent for auditability and decoupling
- Redis Streams for async, decoupled event propagation
- JWT auth (stubbed, demo only)
- Pagination/filtering on GET /courses

## Future Work
- Project all course/lesson data into reco for richer recommendations
- Production-grade auth
- Cloud deployment
- Advanced recommendation algorithms

## Architecture Diagram
See [`/docs/diagram.puml`](docs/diagram.puml) 