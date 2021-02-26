set -xue

git submodule add -f git@github.com:dehasi/dehasi.github.io.git _site

docker run --rm   --volume="$PWD:/srv/jekyll"   -it jekyll/jekyll   jekyll build

cd _site/
#git init
git add .
#git remote add origin git@github.com:dehasi/dehasi.github.io.git
git commit  -a --message "Travis build: $TRAVIS_BUILD_NUMBER" 
#git push --set-upstream origin master --force
git push origin

cd ..
rm -rf _site 
