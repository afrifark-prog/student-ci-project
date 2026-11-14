# Student-CI-Project

A small Python calculator used to demonstrate Continuous Integration (CI) with Jenkins and GitHub webhooks (CMSC 426, In-Class Activity 3).

Every push to `main` sends a webhook to Jenkins. Jenkins checks out the code, runs `build.sh`, executes the unit tests, and marks the build **SUCCESS** or **FAILURE**.

```
Developer --push--> GitHub repo --webhook (HTTPS via ngrok)--> Jenkins --> build.sh (app + unit tests) --> SUCCESS / FAILURE
```

## Repository layout

| Path | Purpose |
|---|---|
| `src/calculator.py` | Application code (`add_numbers`, `subtract_numbers`, `multiply_numbers`, `divide_numbers`) |
| `tests/test_calculator.py` | `unittest` test cases |
| `build.sh` | CI build script for macOS/Linux agents (used by Jenkins) |
| `build.bat` | Equivalent script for Windows agents |
| `Jenkinsfile` | Optional Pipeline-job version of the same build |

## Requirements

- Python 3.8 or newer (no third-party packages needed)
- Git

## Run locally

```bash
git clone https://github.com/<your-username>/student-ci-project.git
cd student-ci-project
python3 -m src.calculator                      # run the app
python3 -m unittest discover -s tests -t . -v  # run the tests
sh ./build.sh                                  # run the full CI script
```

Windows: use `python` instead of `python3` and run `build.bat`.

## Jenkins configuration (summary)

- **Job:** Freestyle project named `Student-CI-Project`
- **Source Code Management:** Git, this repository's HTTPS URL, branch `*/main`
- **Build Triggers:** *GitHub hook trigger for GITScm polling* (backup: *Poll SCM* `H/5 * * * *`)
- **Build Steps:** *Execute shell* → `sh ./build.sh`
- **GitHub webhook:** Payload URL `https://<ngrok-address>/github-webhook/`, content type `application/json`, push events

A failing test makes `build.sh` exit with code 1, which Jenkins reports as a failed build.
