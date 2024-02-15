# Makefile Studying with docker

![un license](https://img.shields.io/github/license/RyosukeDTomita/makefile-study)

## INDEX

- [ABOUT](#about)
- [LICENSE](#license)
- [ENVIRONMENT](#environment)
- [PREPARING](#preparing)
- [HOW TO USE](#how-to-use)
- [ABOUT](#about)

---

## ABOUT

Makefile の使い方を勉強したメモ。

---

## LICENSE

[FIXME](./LICENSE)

---

## ENVIRONMENT

C++17, g++-10, make

---

## PREPARING

1. install docker

---

## HOW TO USE

1. Clone this repository.
2. build the docker image.

```shell
cd makefile-study
docker buildx bake
```

3. Run the docker container to compile and execute

```shell
docker compose run -it make-app make
docker compose run -it make-app make execute
---
```
