import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  connect() {
    
  }
  addNew(event){
   var url = event.currentTarget.dataset.url
    $.ajax({
      url: url
    })
  }

  closeModal(event){
    $("#staticSearchModal").slideToggle()
    // $("#staticSearchModal").remove()
  }

  update(event){

    var url = event.target.value
    $.ajax({
      url: url,
      success: function(data){
        $("#exerciseTarget").append(data)
        $("#staticSearchModal").slideToggle()
      }
    })
  }

  updateList(event){
    debugger;
  }

  newUserSettings(event){
    var url = event.currentTarget.dataset.url
  }
  
}