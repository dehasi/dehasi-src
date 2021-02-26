.PHONY: build
build:
	docker run --rm --volume="`pwd`:/srv/jekyll" -it jekyll/jekyll jekyll build


.PHONY: run
run:
	docker run --rm --volume="`pwd`:/srv/jekyll" -it  --publish 4000:4000 jekyll/jekyll jekyll serve --drafts


.PHONY: local
local:
	git submodule add -f git@github.com:dehasi/dehasi.github.io.git _site
	docker run --rm --volume="`pwd`:/srv/jekyll" -it jekyll/jekyll jekyll build
	cd _site &&  \
	git add . && \
	git commit  -a --message "Local build" && \
	git push origin


.PHONY: travis
travis:
	git submodule add -f git@github.com:dehasi/dehasi.github.io.git _site
	docker run --rm --volume="`pwd`:/srv/jekyll" -it jekyll/jekyll jekyll build
	cd _site &&  \
	git add . && \
	git commit  -a --message "Travis build: ${TRAVIS_BUILD_NUMBER}" && \
	git push origin


.PHONY: clean
clean:
	git rm -f .gitmodules || true
	git rm -f _site || true
	rm -rf _site .jekyll-cache .git/modules .gitmodules
