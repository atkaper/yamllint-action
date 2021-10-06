# yamllint-action

To prevent each build from building a yamllint container over-and-over-again,
this action will use a hosted prebuilt container.

## Usage

```yaml
---
name: yamllint

on:
  pull_request:
    branches:
      - main

jobs:
  yamllint:
    runs-on: ubuntu-latest
    steps:
      - name: Code checkout
        uses: actions/checkout@v2
      - name: Lint YAML
        uses: atkaper/yamllint-action@1.5.0
```

This version will put the yamllint output also in an environment variable called YAML_LINT_OUT for further use in next action steps.
You can use it in a next step using: ${{ env.YAML_LINT_OUT }}


## Forked from

https://github.com/koozz/yamllint-action

## License

MIT
