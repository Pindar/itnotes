# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Jekyll blog source for itnotes.de (German-language IT/DevOps/programming notes blog, running since 2009). Static site: Markdown posts + Jekyll templates, built and served via GitHub Pages / `github-pages` gem. No JS build pipeline is actually in use.

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

Validate posts before committing (no test suite exists; these two scripts are the closest thing):
```bash
ruby check_posts.rb    # verifies every _posts/*.md has required front matter: layout, title, date, categories
ruby check_images.rb   # verifies every image referenced in _posts/*.md exists under assets/
```

## Architecture

- `_posts/` — one Markdown file per post, named `YYYY-MM-DD-slug.md`. Many are migrated from an old WordPress export, so front matter carries legacy fields (`wordpress_id`, `wordpress_url`, `author_*`, `date_gmt`) alongside the Jekyll-required `layout`, `title`, `date`, `categories`. New posts only need the Jekyll-required fields.
- `_layouts/` — `default.html` (site chrome), `page.html`, `post.html`. Theme is `minima` (set in `_config.yml`), these layouts override/extend it.
- `assets/` — images referenced by posts, plus `css/`, `downloads/`, `uploads/`. Post image paths are checked against this directory by `check_images.rb`.
- `_config.yml` — site title/description (German), `permalink: /:categories/:year/:month/:day/:title/`, canonical `url: https://www.itnotes.de`. `exclude:` list must include any new non-Jekyll utility scripts/files added at the repo root (mirrors `check_images.rb`/`check_posts.rb` already there) so Jekyll doesn't try to process them.
- `_site/` — build output, not source; don't hand-edit.
- `CNAME`, `robots.txt`, `sitemap.xml` — GitHub Pages custom domain + SEO plumbing at repo root, served as-is.
- `.eslintrc.js` (Nuxt/Vue config) and `assets/README.md` (Nuxt assets boilerplate) are leftovers from the starter template this repo was originally scaffolded from — there is no Nuxt app here; ignore them rather than trying to wire up JS tooling.

## Content conventions

- Posts are German-language technical notes/articles.
- Categories drive the URL structure (`permalink` includes `:categories`), so a post's `categories` front matter is not cosmetic — it determines its live URL.
