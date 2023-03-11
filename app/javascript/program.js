$.fn.programCreator = function(){
	$(this).find("#program").each(function(){
		$("#start-build").on('click', function(){
			var url = $(this).data('url')

			$.ajax({
				url: url,
				method: 'GET'
			})
		})
	})

	$(this).find("#save").on('click', function(){
		console.log("hit")
		var url = $(this).data('url')
		var payload = {}
		payload['name'] = $("#name").val()
		payload['workouts'] = []
		$(".exercise-card").each(function(){
			var workoutName = $(this).find("#workoutName").text();
			var workout = {}
			workout['name'] = workoutName
			workout['exercises'] = []
			$(this).find('.exercise-list > ul > li').each(function(){
				var exerciseName = this.dataset.name
				var order = this.dataset.order 
				var id = this.dataset.id
				var exercise = {'name': exerciseName,
				'id': id,
				 'order': order} 
				 workout['exercises'].push(exercise)
			})
			payload['workouts'].push(workout)
		})

		$.ajax({
			url: url,
			data: {'program': payload},
			method: 'POST',
			dataType: 'json',
			beforeSend: function(xhr) {
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
			},
		})

	})

}

function buildProgramDaysHTML(){
	$("#workoutSection").each(function(){
		var dayIndex = {
			0: 'Monday',
			1: 'Tuesday',
			2: 'Wednesday',
			3: 'Thursday',
			4: 'Friday',
			5: 'Saturday',
			6: 'Sunday'
		}
		$(this).find(".exercise-card").each(function(index){
			debugger;
		})
	})
}
