#!/bin/sh
# PostToolUse hook: lint the file Claude just edited. Exit 2 feeds the linter output back to Claude.
file=$(sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)
[ -f "$file" ] || exit 0
case "$file" in
  *.rb | */Rakefile | */Gemfile) out=$(bundle exec rubocop "$file" 2>&1) ;;
  *.md) out=$(npx --no-install markdownlint-cli2 "$file" 2>&1) ;;
  *.css) out=$(npx --no-install stylelint "$file" 2>&1) ;;
  *.js) out=$(npx --no-install eslint "$file" 2>&1) ;;
  *.html) out=$(npx --no-install html-validate "$file" 2>&1) ;;
  *.yml | *.yaml) out=$(yamllint -c .yamllint.yml "$file" 2>&1) ;;
  *) exit 0 ;;
esac
status=$?
if [ $status -ne 0 ]; then
  echo "$out" >&2
  exit 2
fi
