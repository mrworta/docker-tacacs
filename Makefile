SW_VER=tacacs-F4.0.4.28
WORK_NAME=tacacs

build:
	docker build --build-arg SW_VER=${SW_VER} -t iss/${WORK_NAME}:latest .

clean: 
	-docker rmi nightserv/${WORK_NAME}:latest

run:
	docker run -d iss/${WORK_NAME}
