/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.html.slim',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/javascript/**/*.vue',    
  ],
  theme: {
    extend: {
      fontFamily: {
        base: [
          'kinto-sans',
          '"ヒラギノ角ゴシック"',
          '"Yu Gothic"',
          'sans-serif'
        ]
      }
    },
  },
  plugins: [],
}
