import path from 'path'
import classy from 'markdown-it-classy'
import MarkdownIt from 'markdown-it'

export default {
  mode: 'spa',
  /*
   ** Headers of the page
   */
  head: {
    title: process.env.npm_package_name || '',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      {
        hid: 'description',
        name: 'description',
        content: process.env.npm_package_description || ''
      }
    ],
    link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }]
  },
  /*
   ** Customize the progress-bar color
   */
  loading: { color: '#fff' },
  /*
   ** Global CSS
   */
  css: ['tachyons/css/tachyons.css'],
  /*
   ** Plugins to load before mounting the App
   */
  plugins: [
    { src: '~/plugins/disqus', mode: 'client' }
  ],
  /*
   ** Nuxt.js dev-modules
   */
  devModules: [
    // Doc: https://github.com/nuxt-community/eslint-module
    '@nuxtjs/eslint-module'
  ],
  /*
   ** Nuxt.js modules
   */
  modules: [
    // Doc: https://axios.nuxtjs.org/usage
    '@nuxtjs/axios',
    '@nuxtjs/sitemap',
    '@nuxtjs/pwa',
    '@bazzite/nuxt-optimized-images'
  ],
  sitemap: {
    hostname: 'https://www.itnotes.de'
  },
  optimizedImages: {
    optimizeImages: true
  },
  /*
   ** Axios module configuration
   ** See https://axios.nuxtjs.org/options
   */
  axios: {},
  /*
   ** Build configuration
   */
  build: {
    /*
     ** You can extend webpack config here
     */
    extend(config, ctx) {
      config.module.rules.push(
        {
          test: /\.md$/,
          loader: 'frontmatter-markdown-loader',
          include: path.resolve(__dirname, 'contents'),
          options: {
            markdown: (body) => {
              const md = new MarkdownIt({
                html: true, // Enable HTML tags in source
                xhtmlOut: false, // Use '/' to close single tags (<br />).
                // This is only for full CommonMark compatibility.
                breaks: true, // Convert '\n' in paragraphs into <br>
                langPrefix: 'language-', // CSS language prefix for fenced blocks. Can be
                // useful for external highlighters.
                linkify: false, // Autoconvert URL-like text to links

                // Enable some language-neutral replacement + quotes beautification
                typographer: false,

                // Double + single quotes replacement pairs, when typographer enabled,
                // and smartquotes on. Could be either a String or an Array.
                //
                // For example, you can use '«»„“' for Russian, '„“‚‘' for German,
                // and ['«\xA0', '\xA0»', '‹\xA0', '\xA0›'] for French (including nbsp).
                quotes: '“”‘’',

                // Highlighter function. Should return escaped HTML,
                // or '' if the source string is not changed and should be escaped externally.
                // If result starts with <pre... internal wrapper is skipped.
                highlight(/* str, lang */) {
                  return ''
                }
              })
              md.use(classy)
              md.renderer.rules.table_open = function(tokens, idx) {
                return '<div class="overflow-auto"><table class="f6 w-100 mw8 center">'
              }
              md.renderer.rules.table_close = function(tokens, idx) {
                return '</table></div>'
              }
              md.renderer.rules.td_open = function(tokens, idx) {
                return '<td class="pv3 pr3 bb b--black-20">'
              }
              md.renderer.rules.th_open = function(tokens, idx) {
                return '<th class="fw6 bb b--black-20 tl pb3 pr3 bg-white">'
              }
              return md.render(body)
            },
            vue: {
              root: 'dynamicMarkdown'
            }
          }
        },
        {
          test: /\.svg$/,
          loader: 'svg-inline-loader'
        }
      )
    }
  },
  generate: {
    routes: [].concat(require('./manifest.json')).map((w) => w.url)
  }
}
