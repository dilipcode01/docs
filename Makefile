up-lms:
	docker-compose -f services/lms/docker-compose.lms.yml up --build

down-lms:
	docker-compose -f services/lms/docker-compose.lms.yml down

up-reco:
	docker-compose -f services/reco/docker-compose.reco.yml up --build

down-reco:
	docker-compose -f services/reco/docker-compose.reco.yml down

db-create-reco:
	docker-compose -f services/reco/docker-compose.reco.yml run --rm reco bundle exec rails db:create

up: network-create db-create-reco
	docker-compose -f services/lms/docker-compose.lms.yml up --build & \
	docker-compose -f services/reco/docker-compose.reco.yml up --build

down:
	docker-compose -f services/lms/docker-compose.lms.yml down; \
	docker-compose -f services/reco/docker-compose.reco.yml down

ssh-lms:
	docker-compose -f services/lms/docker-compose.lms.yml exec lms bash

ssh-reco:
	docker-compose -f services/reco/docker-compose.reco.yml exec reco bash 

lms-up:
	cd services/lms && make up

lms-down:
	cd services/lms && make down

lms-logs:
	cd services/lms && make logs

lms-ssh:
	docker-compose -f services/lms/docker-compose.lms.yml exec lms bash

reco-up:
	cd services/reco && make up

reco-down:
	cd services/reco && make down

reco-logs:
	cd services/reco && make logs

reco-ssh:
	docker-compose -f services/reco/docker-compose.reco.yml exec reco bash 

network-create:
	docker network create lmsnet || true 