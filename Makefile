# Makefile for MkDocs Multilingual Project

VENV := .venv
PYTHON := $(VENV)/bin/python
MKDOCS := $(VENV)/bin/mkdocs

.DEFAULT_GOAL := help

help:
	@echo "Available targets:"
	@echo "  make all         - Clean, setup venv, install deps, validate, and build both languages"
	@echo "  make venv        - Create Python virtual environment"
	@echo "  make deps        - Install Python dependencies"
	@echo "  make build-sk    - Build Slovak documentation"
	@echo "  make build-en    - Build English documentation"
	@echo "  make deploy-all  - Build both and deploy to gh-pages"
	@echo "  make clean       - Delete generated site and venv"
	@echo "  make doctor      - Show version info"

venv:
	rm -rf $(VENV)
	python3 -m venv $(VENV)
	$(PYTHON) -m pip install --upgrade pip

deps:
	$(PYTHON) -m pip install -r requirements_mkdocs.txt

build-sk:
	rm -rf build/sk
	$(MKDOCS) build -f mkdocs_sk.yml -d build/sk

build-en:
	rm -rf build/en
	$(MKDOCS) build -f mkdocs_en.yml -d build/en

clean:
	rm -rf site/ build/ $(VENV)

prepare-site:
	mkdir -p site/sk site/en
	cp -r build/sk/* site/sk/
	cp -r build/en/* site/en/
	cp index.html site/

# Combined deploy-all to ensure clean GH Pages with correct layout
deploy-all: clean venv deps build-sk build-en prepare-site
	@echo "Deploying site..."
	@if [ ! -d ../gh-pages ]; then \
		git worktree add ../gh-pages gh-pages; \
	fi
	rm -rf ../gh-pages/*
	cp -r site/* ../gh-pages/
	cd ../gh-pages && git add . && git commit -m "Deploy SK + EN" && git push origin gh-pages

doctor:
	which $(PYTHON)
	which $(MKDOCS)
	$(MKDOCS) --version
	$(PYTHON) --version
