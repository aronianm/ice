import { Controller } from "@hotwired/stimulus"
export default class extends Controller {

	connect(){
		var tabs = $("#programWorkoutTabs").find('li > button')
	
		if(tabs[0].attributes.active !== true){
			$(tabs[0]).click()
			tabs[0].attributes.active = true
		}
	}
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

  workoutShow(event){
  	var url = event.currentTarget.dataset.url
  	$(".program-section").css("display", "")
  	$(".program-section").addClass('hidden')
  	$(".program-section").attr('active', false)

  	$.ajax({
  		url: url,
  		method: 'GET',
  		success: function(data){
  			$("#workoutTarget").html(data)
  			$("#workoutTarget").attr('active', true)
  			$("#workoutTarget").slideToggle()
  		}
  	})
  }

  create(event){

  	var payload = {'name': "", 'exercises': []}
  	var url = event.currentTarget.dataset.url
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
		  			config['sets'] = set
		  			config['weight'] = weight
		  			config['duration'] = time
		  			exercisePayload['exercise_sets'].push(config)
		  		}

	  		})
	  		payload['exercises'].push(exercisePayload)
	  	}
  	})

  	$.ajax({
  		url: url,
  		data: {'program_workouts': payload},
  		method: 'POST',
  		beforeSend: function(xhr) {
         xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
  	})
  	
  }

  showExtra(event){
  	$(event.currentTarget.parentElement.parentElement).find('.weight-metric').slideToggle()
  }
  
}

