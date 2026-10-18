# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Jekyll blog source for itnotes.de (German-language IT/DevOps/programming notes blog, running since 2009). Static site: Markdown posts + Jekyll templates, built and served via GitHub Pages / `github-pages` gem. The site ships no JavaScript; Node is used only for dev-time linters (`package.json`).

## Commands

Setup:

```bash
brew install rbenv ruby-build
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
bundle install
```

Local dev server:

```bash
bundle exec jekyll serve
```

Setup once per clone (also enables the gitleaks pre-commit hook; needs `brew install gitleaks`):

```bash
bundle install && npm install && bundle exec rake setup
```

Verify (run before every commit; this is how you check your own work):

```bash
bundle exec rake                          # rubocop, rspec (incl. full Jekyll build + html-proofer), check_posts, check_images, all Node linters
bundle exec rspec spec/itnotes/post_checker_spec.rb   # single spec file
npm run lint                              # markdown, css, js, html, yaml, ruby linters
```

## Workflow: test first (TDD/BDD)

- For any change to `lib/`, `check_*.rb` or site behavior: write a failing RSpec example first (`describe` / `context "when ..."` / `it "reports ..."`), see it fail, then implement. Fixtures live in `spec/fixtures/{valid,broken}/`.
- `spec/site_spec.rb` builds the real site and asserts site-level behavior (language, SEO description, no broken internal links); extend it when changing layouts.
- Legacy WordPress/Tumblr posts (before 2020) may have empty `title`/`categories`; do not "fix" categories, they change live URLs.
- Sub-agents in `.claude/agents/`: `content-reviewer` (read-only content review), `ruby-tdd-dev` (test-first Ruby changes), `site-verifier` (read-only full verification). A PostToolUse hook lints each edited file automatically.

## Architecture

- `_posts/` — one Markdown file per post, named `YYYY-MM-DD-slug.md`. Many are migrated from an old WordPress export, so front matter carries legacy fields (`wordpress_id`, `wordpress_url`, `author_*`, `date_gmt`) alongside the Jekyll-required `layout`, `title`, `date`, `categories`. New posts only need the Jekyll-required fields.
- `_layouts/` — `default.html` (site chrome), `page.html`, `post.html`. Theme is `minima` (set in `_config.yml`), these layouts override/extend it.
- `assets/` — images referenced by posts, plus `css/`, `downloads/`, `uploads/`. Post image paths are checked against this directory by `check_images.rb`.
- `_config.yml` — site title/description (German), `permalink: /:categories/:year/:month/:day/:title/`, canonical `url: https://www.itnotes.de`. `exclude:` list must include any new non-Jekyll utility scripts/files added at the repo root (see the existing entries: `Gemfile`, `Rakefile`, `lib`, `spec`, `package.json`, ...) so Jekyll doesn't try to process them.
- `_site/` — build output, not source; don't hand-edit.
- `CNAME`, `robots.txt`, `sitemap.xml` — GitHub Pages custom domain + SEO plumbing at repo root, served as-is.
- `assets/README.md` (Nuxt assets boilerplate) is a leftover from the starter template — there is no Nuxt app here; ignore it.
- `lib/itnotes/`, `spec/`, `Rakefile` — tested Ruby behind `check_posts.rb` / `check_images.rb` (these exit non-zero on problems). Lint configs (`.rubocop.yml`, `.markdownlint-cli2.yaml`, `.stylelintrc.json`, `.yamllint.yml`, `.htmlvalidate.json`, `eslint.config.js`) are dev-only.
- `.githooks/pre-commit` runs gitleaks on staged changes; `.gitleaksignore` holds one reviewed historic finding.

## Content conventions

- Posts are German-language technical notes/articles.
- Categories drive the URL structure (`permalink` includes `:categories`), so a post's `categories` front matter is not cosmetic — it determines its live URL.
