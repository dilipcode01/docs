# LMS + Recommendation Microservices (Rails, JWT, Docker)

## Overview

- **LMS Service**: CRUD for courses/lessons, mark lesson complete, user stats, JWT authentication.
- **Recommendation Service**: Consumes learner history events, recommends next course.
- **Database**: Each service uses its own Postgres instance (UUID PKs).
- **API**: JSON REST APIs for all endpoints.

## Running locally

The goal of this document is to be a guide on how to run all services locally.

### Requirements
- Docker
- Docker Compose

### Assumptions
- You have all the requirements installed.
- You have all the repositories/folders cloned or present in the same parent directory (see example below).

```
LMS/
  ├── Makefile   # <-- THIS IS VERY IMPORTANT
  ├── services/
  │     ├── lms/
  │     └── reco/
  └── docs/
```

### Steps
1. **Copy the Makefile** from the `docs/` folder to the root of your project (if not already present).
2. **Ensure all service folders** (`services/lms`, `services/reco`) are present in the structure above.
3. **Build the Docker images:**
4. **From the root of your project, run:**

   ```sh
   make up
   ```

This will start all services (LMS, Reco, and their databases) using Docker Compose.

---

## Quick Start

From the project root, use the provided Makefile for convenience:

```sh
# Start both services (LMS and Reco) and their databases
make up

# Stop all services
make down

# Start only LMS
make up-lms

# Start only Reco
make up-reco

# Open a shell in the LMS container
make ssh-lms

# Open a shell in the Reco container
make ssh-reco
```

## Access

- **LMS API**: [http://localhost:3001](http://localhost:3001)
- **Reco API**: [http://localhost:3002](http://localhost:3002)

## API Examples

See [`/docs/api.http`](api.http) for ready-to-use HTTPie/curl requests.

### Auth & JWT

- `POST /login` — Get a JWT token (returns a valid UUID user_id).
- Use the returned token as `Authorization: Bearer <token>` for all protected endpoints.

### Core Endpoints

- `POST /courses` — Create a course
- `POST /lessons` — Create a lesson (requires `course_id`)
- `POST /lessons/:id/complete` — Mark a lesson as completed (uses user_id from JWT)
- `GET /users/:id/stats` — Get user learning stats
- `GET /courses` — List courses (supports pagination/filtering)
- `GET /users/:id/next-course` (Reco) — Get next recommended course

## Event Contract

- LMS publishes events (e.g., lesson completion) to Redis Stream `lms_events`.
- Reco consumes these events for recommendations.

## Testing

- Run tests in LMS: `make ssh-lms` then `bundle exec rspec`
- Run tests in Reco: `make ssh-reco` then `bundle exec rspec`

## Architecture Diagram

![Architecture Diagram](diagram.png)

*The PNG diagram is generated from a PlantUML source. To update, edit the PlantUML and re-export as PNG.*

## Design Principles

- SOLID, KISS, DRY, clean architecture
- JWT auth (stubbed, demo only)
- Pagination/filtering on GET /courses

## Future Work

- Project all course/lesson data into reco for richer recommendations
- Production-grade auth
- Cloud deployment
- Advanced recommendation algorithms 