.PHONY: start stop build dbshell

start:
	docker-compose up -d

stop:
	docker-compose down

build:
	docker-compose build

dbshell:
	docker run \
		-it \
		--link wpdocker_db_1:mariadb \
		--rm \
		--net wpdocker_default \
		mariadb \
		sh -c 'exec mysql -hdb -uroot -pwordpress'
