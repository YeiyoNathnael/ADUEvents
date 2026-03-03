# ============================================================
# ADUEvents — Go / Templ / HTMX / Alpine.js / TailwindCSS
# ============================================================
.PHONY: all build run dev templ css watch-css fmt vet clean tidy help

APP_NAME := server
BIN_DIR := ./tmp/bin
BIN_PATH := $(BIN_DIR)/$(APP_NAME)
CMD_PATH := ./cmd/server

## all: build the application (default)
all: build

## fmt: format Go source files
fmt:
	go fmt ./...

## vet: run Go static analysis
vet:
	go vet ./...

## build: compile the Go binary
build: fmt vet
	@mkdir -p $(BIN_DIR)
	go build -o $(BIN_PATH) $(CMD_PATH)

## run: build and run the application
run: build
	$(BIN_PATH)

## dev: build css + generate templ, then run Air live-reload
dev: css templ
	air -c .air.toml

## templ: generate Go code from .templ files
templ:
	templ generate

## css: compile Tailwind CSS (requires Node.js + npm)
css:
	npm run build:css

## watch-css: watch and recompile Tailwind CSS on change
watch-css:
	npm run watch:css

## tidy: tidy Go modules
tidy:
	go mod tidy

## clean: remove build artifacts
clean:
	rm -rf $(BIN_DIR)

## help: list available targets
help:
	@grep -E '^##' $(MAKEFILE_LIST) | sed 's/## //'
