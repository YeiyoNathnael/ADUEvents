# ============================================================
# ADUEvents — Go / Templ / HTMX / Alpine.js / TailwindCSS
# ============================================================

APP_NAME  := aduevents
BIN_DIR   := bin
MAIN_PKG  := ./cmd/server

.PHONY: all build run dev templ css clean tidy help

## all: build the application (default)
all: build

## build: compile the Go binary
build:
	go build -o $(BIN_DIR)/$(APP_NAME) $(MAIN_PKG)

## run: build and run the application
run: build
	./$(BIN_DIR)/$(APP_NAME)

## dev: run with live-reload using Air (https://github.com/air-verse/air)
dev:
	air

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
