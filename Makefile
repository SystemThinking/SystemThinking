# Makefile for MkDocs Multilingual Project

VENV := .venv
PYTHON := $(VENV)/bin/python
MKDOCS := $(VENV)/bin/mkdocs

.DEFAULT_GOAL := help

help: ## Zoznam dostupných príkazov
	@echo "🛠️  Dostupné príkazy:"
	@grep -E '^[a-zA-Z_-]+:.*?##' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

venv: ## Vytvorí virtuálne prostredie
	python3 -m venv $(VENV)
	$(PYTHON) -m pip install --upgrade pip

deps: ## Inštaluje závislosti z requirements_mkdocs.txt
	$(PYTHON) -m pip install -r requirements_mkdocs.txt

build-sk: ## Build Slovenskej dokumentácie
	rm -rf build/sk
	$(MKDOCS) build -f mkdocs_sk.yml -d build/sk

build-en: ## Build Anglickej dokumentácie
	rm -rf build/en
	$(MKDOCS) build -f mkdocs_en.yml -d build/en

prepare-site: ## Spojí obidve verzie do site/ a pridá index + CNAME
	rm -rf site
	mkdir -p site/sk site/en
	cp -r build/sk/* site/sk/
	cp -r build/en/* site/en/
	echo '<!DOCTYPE html><html><head><meta http-equiv="refresh" content="0; url=sk/"></head><body>Redirecting to <a href="sk/">sk</a></body></html>' > site/index.html
	echo 'systemthinking.sk' > site/CNAME

prepare-gh-pages: ## Pripraví gh-pages worktree
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

sync-gh-pages: ## Aktualizuje gh-pages worktree z GitHubu
	cd ../gh-pages && git pull origin gh-pages --rebase

deploy-all: clean venv deps build-sk build-en prepare-site ## Build + deploy do gh-pages
	@echo "Deploying site to GitHub Pages..."
	@if [ ! -d ../gh-pages ]; then \
		git worktree add ../gh-pages gh-pages; \
	fi
	rm -rf ../gh-pages/*
	cp -r site/* ../gh-pages/
	cd ../gh-pages && git add . && git commit -m "Deploy SK + EN" && git push origin gh-pages

run: ## Spustí lokálne mkdocs serve pre SK aj EN na rôznych portoch
	@echo "Spúšťam SK verziu na http://localhost:8000"
	$(MKDOCS) serve -f mkdocs_sk.yml &
	@echo "Spúšťam EN verziu na http://localhost:8001"
	$(MKDOCS) serve -f mkdocs_en.yml -a 127.0.0.1:8001

reset: clean venv deps build-sk build-en prepare-site ## Vyčistí a znova postaví celý projekt

clean: ## Vyčistí site/, build/, .venv a gh-pages worktree
	rm -rf site/ build/ .venv ../gh-pages

status: ## Zobrazí git status
	git status

doctor: ## Zobrazí info o mkdocs, python a ich cestách
	which $(PYTHON)
	which $(MKDOCS)
	$(MKDOCS) --version
	$(PYTHON) --version
