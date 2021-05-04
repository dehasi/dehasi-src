.PHONY: build
build:
	docker run --rm --volume="`pwd`:/srv/jekyll" -it dehasi/jekyll jekyll build


.PHONY: run
run:
	docker run --rm --volume="`pwd`:/srv/jekyll" -it  --publish 4000:4000  dehasi/jekyll jekyll serve --drafts --trace


.PHONY: local
local:
	docker run --rm --volume="`pwd`:/srv/jekyll" -it dehasi/jekyll jekyll build
	cd _site &&  \
	git add . && \
	git commit  -a --message "Local build" && \
	git push origin


.PHONY: travis
travis:
	docker run --rm --volume="`pwd`:/srv/jekyll" -it dehasi/jekyll jekyll build
	cd _site &&  \
	git add . && \
	git commit  -a --message "Travis build: ${TRAVIS_BUILD_NUMBER}" && \
	git push origin


.PHONY: module
module:
	git submodule add -f git@github.com:dehasi/dehasi.github.io.git _site


.PHONY: clean
clean:
	rm -rf .jekyll-cache
