setup:
	cd dbserver && chmod 644 mysqld.cnf && chmod 600 ssl/*.pem && docker build -t u5572396/csvs_dbserver_i .
	cd webserver && docker build -t u5572396/csvs_webserver_i .

up:
	docker-compose up -d

down:
	docker-compose down

build:
	docker-compose up --build -d

clean:
	docker-compose down -v
