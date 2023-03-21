import { Controller } from "@hotwired/stimulus"
export default class extends Controller {


  show(event){
  	var target = document.getElementById(event.currentTarget.dataset.show)
  	if(target.attributes['active'] === undefined){
  		$(".program-section").addClass('hidden')
	    $(".program-section").attr('active', false)
	    $(".program-section").css('display', '')
	    $(target).attr('active', true)
	    $(target).slideToggle()
  	}else if(target.attributes['active'].value !== 'true'){
	    $(".program-section").addClass('hidden')
	    $(".program-section").attr('active', false)
	    $(".program-section").css('display', '')
	    $(target).attr('active', true)
	    $(target).slideToggle()
	}
  }

  create(event){

  	var payload = {'name': "", 'exercises': []}
  	payload['name'] = $("#workout_name").val()
  	var day = $("#workout_date").val() || $(".circle").data('index')
  	if(day !== undefined){
  		payload['day'] = day
  	}
  	var startTime = $("#workout_start").val()
  	var endTime = $("#workout_end").val()
  	if(startTime != ''){
  		payload['workoutStart'] = startTime
  	}
  	if( endTime != ''){
  		payload['workoutEnd'] = endTime
  	}
  	
  	$("#exerciseSection").find(".exercise-row").each(function(){
  		var exercisePayload = {}
  		var exerciseID = $(this).find("#exercise").val()
  		if(exerciseID != "Selected Exercise"){
	  		exercisePayload['exercise_id'] = exerciseID
	  		exercisePayload['exercise_sets'] = []
	  		$(this).find('.set').each(function(index) {
	  			var reps = $(this).find('.reps').val()
	  			var set = index + 1
	  			var weight = $(this).find('.weight').val()
	  			var time = $(this).find(".time").val()
	  			var config = {}
	  			if(reps.length > 0){
		  			config['reps'] = reps
		  			config['set'] = set
		  			config['weight'] = weight
		  			config['time'] = time
		  			exercisePayload['exercise_sets'].push(config)
		  		}

	  		})
	  		payload['exercises'].push(exercisePayload)
	  	}
  	})

  	console.log(payload)
  	
  }

  showExtra(event){
  	$(event.currentTarget.parentElement.parentElement).find('.weight-metric').slideToggle()
  }
  
}

