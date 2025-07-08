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
	rm -rf site/ build/ .venv ../gh-pages

prepare-site:
	rm -rf site
	mkdir -p site/sk site/en
	cp -r build/sk/* site/sk/
	cp -r build/en/* site/en/
	echo '<!DOCTYPE html><html><head><meta http-equiv="refresh" content="0; url=sk/"></head><body>Redirecting to <a href="sk/">sk</a></body></html>' > site/index.html
	echo 'systemthinking.sk' > site/CNAME

prepare-gh-pages:
	@if [ -d ../gh-pages ]; then \
		if [ ! -f ../gh-pages/.git ]; then \
			echo "Removing invalid gh-pages worktree..."; \
			rm -rf ../gh-pages; \
		fi; \
	fi
	@git worktree prune
	@if [ ! -d ../gh-pages ]; then \
		git worktree add ../gh-pages gh-pages; \
	fi

sync-gh-pages:
	cd ../gh-pages && git pull origin gh-pages --rebase

# Deployment (no GitHub Actions)
deploy-all: clean venv deps build-sk build-en prepare-site
	@echo "Deploying site to GitHub Pages..."
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
