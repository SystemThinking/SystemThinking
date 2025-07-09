# Makefile

HUGO=hugo
PUBLIC_DIR=public
BRANCH=gh-pages

.PHONY: build deploy clean

# Lokálny build
build:
	$(HUGO)

# Vyčistí priečinok public/ (POZOR: iba ak nemáš worktree!)
clean:
	rm -rf $(PUBLIC_DIR)

# Deploy do gh-pages (cez existujúci worktree)
deploy: build
	cd $(PUBLIC_DIR) && \
	git add . && \
	git commit -m "Deploy Hugo site" && \
	git push origin $(BRANCH)
