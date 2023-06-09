// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import './add_jquery'
import 'flowbite';
// Inbox script starts
// Add DataTables jQuery plugin




document.addEventListener("turbo:before-stream-render", function (event) {
  event.preventDefault();

  /* Transition the old frame away ... */
  console.log("turbo:before-stream-render", event.detail.newStream.target);

  event.detail.newStream.performAction();
  var el = document.getElementById("message-container")
  el.scrollTo(0, el.scrollHeight);
});
