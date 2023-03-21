import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  connect(){
    debugger;
  }
  reset() {
    this.element.reset()
  }
  
}