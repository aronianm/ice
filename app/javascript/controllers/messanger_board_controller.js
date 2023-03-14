import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  connect() {
    this.element.scrollTo(0, this.element.scrollHeight);
  }

  message_utils(event){
    $("#messageUtils").toggleClass('hidden')
    if(event.target.style.transform === ''){
      event.target.style.transform =  "rotateX(180deg)"
    }else{
      event.target.style.transform =  ""
    }
  }
  
}