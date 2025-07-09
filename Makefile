# Makefile

HUGO=hugo
PUBLIC_DIR=public
BRANCH=gh-pages

.PHONY: build deploy clean

# Lokálny build
build:
	$(HUGO)

# Vyčistí priečinok public/
clean:
	rm -rf $(PUBLIC_DIR)

# Deploy do gh-pages
deploy: build
	cd $(PUBLIC_DIR) && \
	git init && \
	git remote add origin git@github.com:SystemThinking/SystemThinking.git && \
	git checkout -b $(BRANCH) && \
	git add . && \
	git commit -m "Deploy Hugo site" && \
	git push --force origin $(BRANCH)

