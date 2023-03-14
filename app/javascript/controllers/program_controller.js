import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  first(event) {
    var url = event.target.dataset.url 
    $.ajax({
      url: url,
      success: function(data){
        $("#first_section").html(data)
        
      }
    })
  }

  addWorkout(event){
    var url = event.target.dataset.url 
    $.ajax({
      url: url
    })
  }

  workoutShow(event){
    var url = event.target.dataset.url 
    $.ajax({
      url: url
    })
  }
  
}