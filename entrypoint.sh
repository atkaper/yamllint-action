#!/bin/sh

# The first run will add github source code annotations
yamllint . -f github
RETVAL=$?

# The second run (only executed when first has failures) will send simple output back for use in further notifications
if [ "${RETVAL}" != "0" ]
then
  YAML_LINT_OUT=$(yamllint . -f standard)
else
  YAML_LINT_OUT=""
fi

echo "YAML_LINT_OUT<<EOF" >> ${GITHUB_ENV}
echo "${YAML_LINT_OUT}" >> ${GITHUB_ENV}
echo "EOF" >> ${GITHUB_ENV}

# send back the original return code
exit ${RETVAL}

