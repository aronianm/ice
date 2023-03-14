import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  connect(){
    var el = this.element
  }
  dropdown() {
    $("#dropdownNavbar").slideToggle( "slow" )
  }

  request(event){
   var url = event.currentTarget.dataset.url

   $.ajax({
    url: url
   })
  }

  sendRequest(event){
    var url = event.currentTarget.dataset.url

   $.ajax({
    url: url,
    beforeSend: function(xhr) {
       xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    },
    method: 'Post',
    success: function(data){
      $("#requestTrainorButton").remove()
      $("#messageUtils").remove()
    }
   })
  }

  preAcceptUser(event){
    var url = event.currentTarget.dataset.url
    $.ajax({
    url: url,
      beforeSend: function(xhr) {
         xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      },
      method: 'GET'
   })
  }

  acceptDeclineUser(event){
    var url = event.currentTarget.dataset.url
    $.ajax({
    url: url,
    beforeSend: function(xhr) {
       xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    },
    method: 'Post'
   })

  }

  
}