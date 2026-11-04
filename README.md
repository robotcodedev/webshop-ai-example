# Web shop acceptance tests

The example project of [RobotCode's AI agents guide](https://robotcode.io/guides/ai-agents/): Robot Framework tests for a small web shop, in the state the guide's sessions start from. Some things in it are wrong on purpose, because the sessions find them.

## Setup

```sh
uv sync                     # Robot Framework, RobotCode and the Browser library in .venv
source .venv/bin/activate   # on Windows: .venv\Scripts\activate
rfbrowser init              # once, after installing or updating the Browser library
```

## Running the tests

```sh
robotcode robot              # all tests, against the local shop
robotcode -p dev robot       # in Firefox
robotcode -p ci robot        # against the staging shop, as the CI does
```

Results go to `results/`. The requirements the tests check are in `requirements/`.

Tests with the Browser library need the shop's page, at `http://localhost:8080`:

```sh
python -m http.server 8080 --bind 127.0.0.1 --directory webshop
```
