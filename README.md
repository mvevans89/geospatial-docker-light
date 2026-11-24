# geospatial-docker-light

A docker image similar to the rocker geospatial image but with several dependencies removed to make it lighter for PRIDE-C. It is stored on Docker Hub at https://hub.docker.com/r/mvevans89/geolight.

## to build and publish

Set the version once and use it for the image label and both tags. Pushing `latest` too means `docker pull mvevans89/geolight` gets the new image.

To see the version history (and ensure you bump appropriately):

```
curl -s "https://hub.docker.com/v2/repositories/mvevans89/geolight/tags?page_size=100&ordering=last_updated" \
  | jq -r '.results[] | "\(.name)\t\(.last_updated)"'
```

```
VERSION=X.X.X
docker build --build-arg VERSION=$VERSION \
  -t mvevans89/geolight:$VERSION \
  -t mvevans89/geolight:latest .
docker push mvevans89/geolight:$VERSION
docker push mvevans89/geolight:latest
```

Check the label on a built image:

```
docker inspect --format '{{ index .Config.Labels "version" }}' mvevans89/geolight:latest
```

## to add version to github 

commit, push etc.

```
git push
gh release create v$VERSION --generate-notes --title "v$VERSION"
```

## to use

Build `geolight` image. This can take a long time

```
docker build -t mvevans89/geolight .
```

Or pull

```
docker pull mvevans89/geolight
```

### Run interactively

```
docker run --rm \
--mount type=bind,src=./input,dst=/app/input \
--mount type=bind,src=./output,dst=/app/output \
-it mvevans89/geolight
```

```
docker run -it mvevans89/geolight
```

### Various tests in R

Basic INLA test

```
R
library(INLA)
set.seed(123)
n <- 100
x <- rnorm(n)
y <- 1 + 2 * x + rnorm(n, sd = 0.5)
data <- data.frame(y = y, x = x)
result <- inla(y ~ x, family = "gaussian", data = data)
summary(result)
```

INLA BYM test

```
R
library(INLA)
library(devtools)
source('https://raw.githubusercontent.com/hrue/r-inla-testing/refs/heads/main/test-bym/runme2.R')
```