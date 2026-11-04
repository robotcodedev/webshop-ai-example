# Web shop acceptance tests

Robot Framework tests for our web shop, run with RobotCode.

## Environment

- Python dependencies are managed with uv (`pyproject.toml`, `uv.lock`). The project's environment is `.venv`, and it is active in the terminal. After changing `pyproject.toml`, run `uv sync`.
- RobotCode is installed in `.venv` with all extras. Use the RobotCode skill for all work on the tests.
- The Browser library needs `rfbrowser init` after it is installed or updated. It downloads Playwright and the browsers.

## The shop

- The suites talk to the shop through `libraries/ShopLibrary.py`, which runs the shop in memory, so they need no server. The shop's test users, prices and stock are defined there.
- The shop's web page, for tests with the Browser library, is served at `BASE_URL`, locally `http://localhost:8080`.
- Profiles in `robot.toml`: `dev` runs locally in Firefox, `ci` runs against the staging shop. The CI runs `robotcode -p ci robot` (`.github/workflows/tests.yml`).

## Conventions

- There is one suite per area in `tests/`: login, cart, orders and search. Each suite names its team with `Metadata    Owner`. The suites for login, cart and orders also tag their tests with their area (`Test Tags`).
- Tests that belong to the smoke test are tagged `smoke`.
- The tests of login, cart and orders name their requirement with `[Metadata]    Requirement    SHOP-<number>`, and those with a high risk also have `[Metadata]    Risk    high`. New tests do the same. The requirements are in `requirements/`, one Markdown file each.
- Keywords go into the resource file of their area in `resources/`, and keywords in Python into `libraries/ShopLibrary.py`.
- Runs write their results to `results/`.
