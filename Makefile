# Makefile pre Hugo deploy BEZ worktree
# Používa sa len ak public/ NIE JE pripojený ako git worktree

HUGO = hugo
PUBLIC_DIR = public
BRANCH = gh-pages

.PHONY: build deploy clean

# 1️⃣ Build: vygeneruje statický web do public/
build:
	$(HUGO)

# 2️⃣ Clean: vymaže public/ (použi, keď chceš čistý rebuild)
clean:
	rm -rf $(PUBLIC_DIR)

# 3️⃣ Deploy: inicializuje git v public/, nasadí do gh-pages
deploy: build
	cd $(PUBLIC_DIR) && \
	git init && \
	git remote add origin git@github.com:SystemThinking/SystemThinking.git && \
	git checkout -b $(BRANCH) && \
	git add . && \
	git commit -m "Deploy Hugo site" && \
	git push --force origin $(BRANCH)
