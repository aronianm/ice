/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./app/**/*.{html,js,erb}",
  './node_modules/flowbite/**/*.js'],
  theme: {
    extend: {},
  },
  plugins: [
        require('flowbite/plugin')
    ]
}