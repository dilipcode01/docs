# LMS + Recommendation Microservices (Rails, JWT, Docker)

## Overview

- **LMS Service**: CRUD for courses/lessons, mark lesson complete, user stats, JWT authentication.
- **Recommendation Service**: Consumes learner history events, recommends next course.
- **Database**: Each service uses its own Postgres instance (UUID PKs).
- **API**: JSON REST APIs for all endpoints.

## Running locally

The goal of this document is to be a guide on how to run all services locally.

### Requirements
- Docker (tested with Docker version 26.1.3)
- Docker Compose (tested with Docker Compose version v2.20.2)

### Assumptions
- You have all the requirements installed.
- You have all the repositories/folders cloned or present in the same parent directory (see example below).

```