# DecentDevContainer

## SGXDev

- Build locally

```sh
docker build \
	-t ghcr.io/lsd-ucsc/decent-sgxdev:local \
	./SGXDev
```

## SGXSolDev

- Build locally

```sh
docker build \
	--build-arg BASE_IMG_TAG=local \
	-t ghcr.io/lsd-ucsc/decent-sgxsoldev:local \
	./SGXSolDev
```

## GethNode

- Build locally

```sh
docker build \
	--progress=plain \
	-t ghcr.io/lsd-ucsc/decent-gethnode:local \
	./GethNode
```
