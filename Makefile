# Makefile pre Hugo deploy do gh_hugo branch

HUGO = hugo
REPO = https://github.com/SystemThinking/SystemThinking.git
BRANCH = gh_hugo
BUILD_DIR = public

.PHONY: build clean deploy

build:
	$(HUGO) -D

clean:
	rm -rf $(BUILD_DIR)/.git

deploy: build clean
	cd $(BUILD_DIR) && \
	git init && \
	git remote add origin $(REPO) && \
	git checkout -b $(BRANCH) && \
	git add . && \
	git commit -m "Deploy Hugo site" && \
	git push --force origin $(BRANCH)
