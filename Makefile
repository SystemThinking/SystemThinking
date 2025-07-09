# Makefile pre Hugo deploy bez worktree

HUGO = hugo
PUBLIC_DIR = public
BRANCH = gh-pages

.PHONY: build deploy clean

# Build: vytvorí obsah do public/
build:
	$(HUGO)

# Clean: vymaže priečinok public/
clean:
	rm -rf $(PUBLIC_DIR)

# Deploy: inicializuje git v public/, nasadí na gh-pages (zmaže históriu, ale ty to nechceš riešiť teraz)
deploy: build
	cd $(PUBLIC_DIR) && \
	git init && \
	git remote add origin git@github.com:SystemThinking/SystemThinking.git && \
	git checkout -b $(BRANCH) && \
	git add . && \
	git commit -m "Deploy Hugo site" && \
	git push --force origin $(BRANCH)
