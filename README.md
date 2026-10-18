# itnotes

Source of [itnotes.de](https://www.itnotes.de): a German-language blog with notes on IT, lean development, DevOps and programming, running since 2009.

It is a static [Jekyll](https://jekyllrb.com) site (theme `minima`, built with the `github-pages` gem) and is served via GitHub Pages. The site ships no JavaScript; Node is only used for dev-time linters.

## What is in this repo

| Path | Purpose |
| --- | --- |
| `_posts/` | One Markdown file per post, named `YYYY-MM-DD-slug.md` |
| `_layouts/` | `default`, `page` and `post` layouts (extend the `minima` theme) |
| `assets/` | Images, CSS, downloads and uploads used by posts |
| `_config.yml` | Site title, description, permalink scheme, canonical URL |
| `about.md`, `book-shelf.md`, `datenschutz.md`, `index.md` | Static pages |
| `lib/`, `spec/`, `check_posts.rb`, `check_images.rb` | Tested Ruby behind the post and image checks |
| `Rakefile` | Entry point for all checks |
| `.githooks/` | Pre-commit hook running gitleaks |
| `.github/workflows/ci.yml` | CI: runs `bundle exec rake` and gitleaks |
| `_site/` | Build output, generated, do not edit |

## Step-by-step setup

1. **Clone the repository**

   ```bash
   git clone https://github.com/Pindar/itnotes.git
   cd itnotes
   ```

2. **Install Ruby** (version from `.ruby-version`) via rbenv

   ```bash
   brew install rbenv ruby-build
   echo 'eval "$(rbenv init -)"' >> ~/.zshrc
   exec zsh
   rbenv install
   ```

3. **Install Node.js** (CI uses 22) for the linters, and gitleaks for the pre-commit hook

   ```bash
   brew install node gitleaks
   ```

4. **Install dependencies and activate the git hook** (once per clone)

   ```bash
   bundle install && npm install && bundle exec rake setup
   ```

5. **Start the local dev server**

   ```bash
   bundle exec jekyll serve
   ```

   The site is then available at <http://localhost:4000>.

## Writing a new post

1. Create `_posts/YYYY-MM-DD-slug.md` with this front matter:

   ```yaml
   ---
   layout: post
   title: "Titel des Beitrags"
   date: 2026-01-31 12:00:00 +0100
   categories: [devops]
   ---
   ```

2. Write the post in German Markdown. Put images in `assets/` and reference them with alt text.
3. Check the result in the dev server.
4. Run the checks (see below) and commit.

> **Note:** `categories` is part of the permalink (`/:categories/:year/:month/:day/:title/`). Changing the categories of an existing post changes its live URL. Older WordPress/Tumblr posts (before 2020) may have empty `title` or `categories` on purpose.

## Checks

Run everything before every commit:

```bash
bundle exec rake
```

This runs rubocop, rspec (including a full Jekyll build and html-proofer), `check_posts`, `check_images` and all Node linters.

Useful subsets:

```bash
bundle exec rspec spec/itnotes/post_checker_spec.rb   # a single spec file
bundle exec rake posts                                # front matter check
bundle exec rake images                               # image reference check
npm run lint                                          # markdown, css, js, html, yaml, ruby linters
```

## Contributing changes to the tooling

Changes to `lib/`, `check_*.rb` or site behavior are done test first: write a failing RSpec example (fixtures in `spec/fixtures/{valid,broken}/`), then implement. New non-Jekyll files at the repo root must be added to the `exclude:` list in `_config.yml`.

## Deployment

Pushing to `master` publishes the site through GitHub Pages under the custom domain in `CNAME`. Work on a branch, open a pull request and let CI pass first.
