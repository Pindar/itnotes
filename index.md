---
layout: default
title: Home
---
<div class="max-w-4xl mx-auto px-4 py-8">
  <!-- Header -->
  <header class="mb-12">
    <h1 class="text-3xl font-bold text-gray-800 mb-4">IT notes</h1>
    <p class="text-lg text-gray-600">
      IT topics briefly noted or recorded in detail in an article.
    </p>
  </header>

  <!-- Post-Liste -->
  <section>
    <h2 class="text-2xl font-semibold text-gray-700 mb-6">Alle Beiträge</h2>
    <div class="space-y-8">
      {% for post in site.posts %}
        <article class="border-b border-gray-200 pb-8">
          <!-- Metadaten (Datum, Kategorien) -->
          <div class="flex flex-wrap items-center text-sm text-gray-500 mb-2">
            <time class="mr-4">{{ post.date | date: "%d.%m.%Y" }}</time>
            {% for category in post.categories %}
              <span class="mr-2">#{{ category }}</span>
            {% endfor %}
          </div>
          <!-- Titel und Link -->
          <h3 class="text-xl font-semibold mb-2">
            <a href="{{ post.url | relative_url }}" class="text-gray-800 hover:text-blue-600">
              {{ post.title }}
            </a>
          </h3>
          <!-- Excerpt (Vorschau-Text) -->
          <p class="text-gray-600">{{ post.excerpt }}</p>
        </article>
      {% endfor %}
    </div>
  </section>
</div>
