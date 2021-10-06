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
      - master
      - main

jobs:
  validate-yml-files:
    runs-on: ubuntu-latest
    steps:
      # cancel any previous pending builds on this PR, later migrate to: https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#concurrency
      - uses: technote-space/auto-cancel-redundant-job@v1

      - name: Checkout
        uses: actions/checkout@v2

      - name: Run yamllint
        uses: atkaper/yamllint-action@2.0.0

      - name: Write yamllint output as pull request comment
        uses: actions/github-script@v5
        if: ${{ always() }}
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          script: |
            info = `${{ env.YAML_LINT_OUT }}`;
            if (info == '') { info = 'OK'; };
            const output = `#### Yaml-Lint Validation Report

            \`\`\`\n` + info + `\n\`\`\`
            `;
            github.rest.issues.createComment({
              owner: context.repo.owner,
              repo: context.repo.repo,
              issue_number: context.issue.number,
              body: output
            })

```

Make sure you create a .yamllint config file in the root of your project with settings as needed.

This version will put the yamllint output also in an environment variable called YAML_LINT_OUT for further use in next action steps.
You can use it in a next step using: ${{ env.YAML_LINT_OUT }}
In above example it writes the status as PR conversation comment.

## Forked from

https://github.com/koozz/yamllint-action

## License

MIT
