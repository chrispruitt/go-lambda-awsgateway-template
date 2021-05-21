.PHONY: test testall start-test-server
NAME=go-lambda-template
VERSION=latest
DOCKER_ARGS=--name $(NAME) \
	--rm -d \
	-v "`pwd`/build":/var/task:ro,delegated \
	-e AWS_DEFAULT_REGION \
	-e AWS_ACCESS_KEY_ID \
	-e AWS_SESSION_TOKEN \
	-e AWS_SECRET_ACCESS_KEY \
	-e DOCKER_LAMBDA_STAY_OPEN=1 \
	-p 9001:9001 \
	lambci/lambda:go1.x $(NAME)

build: clean
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o build/$(NAME) main.go
	cd build && zip $(NAME)-$(VERSION).zip $(NAME)

clean:
	rm -rf build

release:
	git tag -a $(VERSION) -m "release version $(VERSION)" && git push origin $(VERSION)
	goreleaser --rm-dist

start-test-server: build
	docker run $(DOCKER_ARGS)

stop-test-server:
	docker rm -f $(NAME) || true

test: stop-test-server start-test-server
	sleep 1
	./test.sh
	docker logs $(NAME)

test-live:
	./test-live.sh $(NAME)

