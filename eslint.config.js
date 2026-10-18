// Dev-only. The site ships no JavaScript; this lints any config scripts at the repo root.
module.exports = [
  { ignores: ['_site/**', 'node_modules/**', 'vendor/**', 'assets/**'] },
  {
    files: ['**/*.js'],
    languageOptions: { ecmaVersion: 2022, sourceType: 'commonjs' },
    rules: {},
  },
];
