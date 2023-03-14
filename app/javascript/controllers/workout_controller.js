import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  submitWorkout() {
  	var form = $("form#workoutForm")
  	var inputs =  form.find('input, select, textarea').serializeArray()
  	var payload = {'workout': {'name': "", "day": "", "notes": ""}, "program": {'program_id': ""}}
  	var url = form.attr("action")
  	var method = form.attr('method')
  	for(var i=0; i < inputs.length; i++){
  		var input = inputs[i]
  		if(input.name.includes("program")){

  			payload['program'][input.name] = input.value
  		}else{
  			payload['workout'][input.name] = input.value
  		}
 
  	}

  	$.ajax({
  		url: url, 
  		data: payload,
  		method: method,
  		beforeSend: function(xhr) {
		   xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
			},
  		dataType: "json",
  		complete: function(data){
  			window.location.reload()
  		}
  	})
  	
  }
  
}

