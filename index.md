---
layout: default
title: Home
lang: en
description: "Everything is an Experiment. IT topics on DevOps, programming, and lean development — briefly noted or written up in full."
---
<section class="hero">
  <h1>IT notes</h1>
  <p class="lead">IT topics briefly noted or recorded in detail in an article.</p>
</section>

{% assign years = site.posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% for year in years %}
<section class="post-year">
  <h2>{{ year.name }}</h2>
  <ul class="post-list">
    {% for post in year.items %}
    <li>
      <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%d.%m." }}</time>
      <a class="post-link" href="{{ post.url | relative_url }}">{{ post.title }}</a>
    </li>
    {% endfor %}
  </ul>
</section>
{% endfor %}
