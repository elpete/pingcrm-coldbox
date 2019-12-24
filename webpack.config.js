const elixir = require("coldbox-elixir");
const path = require("path");

module.exports = elixir(mix => {
    mix.css("app.css");
    mix.vue("app.js");
});
