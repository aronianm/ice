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

  closeProfile(event){
    $('#profileModal').slideToggle()
  }

  renderRequest(event){
    var el = this.element
    var url = event.currentTarget.dataset.url
    var method = event.currentTarget.dataset.method || 'GET'
     $.ajax({
      method: method,
      url: url,
      success: function(data){
        $('#profileModal').remove();
        $(el).append(data)
        $(el).find("#profileModal").slideToggle()
      }
     })
  }

  requestChat(event){
    var url = event.currentTarget.dataset.url
    $.ajax({
      url: url,
      method: 'POST',
      beforeSend: function(xhr) {
         xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      },
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