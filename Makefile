
BINARY_NAME=tasker


SRC_DIR=./


MODULE_NAME=github.com/NukeDev/Tasker


VERSION=$(shell git describe --tags --always)


LDFLAGS=-ldflags "-X main.Version=$(VERSION)"

.PHONY: all build run clean release


all: build


build:
	@echo "Building $(BINARY_NAME)..."
	GOOS=linux GOARCH=amd64 go build $(LDFLAGS) -o $(BINARY_NAME) $(SRC_DIR)


run: build
	@echo "Running $(BINARY_NAME)..."
	./$(BINARY_NAME)


clean:
	@echo "Cleaning up..."
	rm -f $(BINARY_NAME)


release: clean
	@echo "Creating release..."
	GOOS=linux GOARCH=amd64 go build $(LDFLAGS) -o $(BINARY_NAME)-$(VERSION)-linux-amd64 $(SRC_DIR)
	GOOS=darwin GOARCH=amd64 go build $(LDFLAGS) -o $(BINARY_NAME)-$(VERSION)-darwin-amd64 $(SRC_DIR)
	GOOS=windows GOARCH=amd64 go build $(LDFLAGS) -o $(BINARY_NAME)-$(VERSION)-windows-amd64.exe $(SRC_DIR)


test:
	@echo "Running tests..."
	go test ./...


deps:
	@echo "Downloading dependencies..."
	go mod tidy

docker-up:
	@echo "Starting compose..."
	docker compose up -d

docker-down:
	@echo "Stopping compose..."
	docker compose down