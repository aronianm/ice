$.fn.Workouts = function(){

	$(this).find("a.workouts_links").each(function(){
		var baseClasses = "inline-flex p-4 border-b-2 rounded-t-lg border-transparent group"
		var activeClasses = "text-blue-600 border-blue-600 active"
		var InactiveClasses = "hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300 group"
		
		var baseSVGClasses = "w-5 h-5 mr-2 "
		var activeImageClasses = "text-blue-600 dark:text-blue-500"
		var inActiveImageClasses = "text-gray-400 group-hover:text-gray-500 dark:text-gray-500 dark:group-hover:text-gray-300"
		$(this).on('click', function(){
			$(".workouts_links").removeClass(activeClasses);
			$(".workouts_links > svg").removeClass(activeImageClasses);
			$(this).addClass(activeClasses);
			$(this).removeClass(InactiveClasses);
			$(this).find("svg").addClass(activeImageClasses)
			$(this).find("svg").removeClass(inActiveImageClasses)
		})
	})
}
$.fn.orderTable = function(){
	$(this).find('tbody > tr').each(function(index){
		$(this).find('td:first').html(index + 1)
	})
}
$.fn.WorkoutCreator = function(){

	var workoutStepperActiveClass = "w-full p-4 text-green-700 border border-green-300 rounded-lg bg-green-50 dark:bg-gray-800 dark:border-green-800 dark:text-green-400"
	var workoutStepperIncomplete = "w-full p-4 text-blue-700 bg-blue-100 border border-blue-300 rounded-lg dark:bg-gray-800 dark:border-blue-800 dark:text-blue-400"
	var currentStepper = 0
	$(this).find(".workout-stepper").each(function(){
		var steppers = $(this).find("li > div")
		$(steppers).on('click', function(){
			
			if($(this).data('require')){
				required_stepper = $(this).data('require')
				for(var i = 0; i < required_stepper.length; i++){
					var req = required_stepper[i]
					var reqInput = $(req.id)
					if($(reqInput).val() === ''){
						var savedClassList = []
						for(var c = 0; c < reqInput[0].classList.length; c++){
							savedClassList.push(reqInput[0].classList[c])
						}
						reqInput[0].classList = []
						var inputClass = "bg-red-50 border border-red-500 text-red-900 placeholder-red-700 text-sm rounded-lg focus:ring-red-500 focus:border-red-500 block w-full p-2.5 dark:bg-red-100 dark:border-red-400"
						var errorHTML = '<p class="mt-2 text-sm text-red-600 dark:text-red-500"><span class="font-medium">Oops!</span> This input needs a value</p>'
						$(reqInput[0]).addClass(inputClass)
						setTimeout(function(){
							reqInput[0].classList = []
							for(var c = 0; c < savedClassList.length; c++){
								$(reqInput[0]).addClass(savedClassList[c])
							}
						}, 2000)
						return false
					}
				}
			}
			var target = parseInt(this.attributes.target.value)
			if((target - currentStepper) > 1){
				return false
			}
			currentStepper += 1
			$(".stepper-targets").addClass('hidden')
			$(`.stepper-targets[key='${target}']`).removeClass('hidden')
			for(var i = 0; i < steppers.length; i++){
				steppers[i].classList = []
				index = parseInt(steppers[i].attributes.target.value)
				if(index <= target ){
					$(steppers[i]).addClass(workoutStepperActiveClass)
				}else{
					$(steppers[i]).addClass(workoutStepperIncomplete )
				}
			}
		})
	})

	$(this).find("#workoutAdd").on('change', function(){
		var url = this.value
		$.ajax({
			url: url,
			success: function(data){
				$("#exerciseTable > tbody").append(data)
				$("#exerciseTable").orderTable()
				$("#workoutAdd > option:first")[0].selected = true
			}
		})
	})

	$(this).find("#save").on('click', function(event){
		var url = $(this).data('url')
		var payload = {'workouts': {'name': "", "notes": "", 'exercises': []}}
		payload['workouts']['name'] = $("#workout_name").val()
		payload['workouts']['notes'] = $("#workout_notes").val()
		
		$("#exerciseTable > tbody > tr").each(function(){

			exercise  = {
				'exercise_id': this.dataset.id,
				'details': {}
			}
			details = {}
			details['sets'] = $(this).find("#sets").val()
			details['reps'] = $(this).find("#reps").val()
			details['duration'] = $(this).find("#duration").val()
			exercise['details'] = details
			payload['workouts']['exercises'].push(exercise)
		})
		$.ajax({
			url: url,
			method: 'POST',
			beforeSend: function(xhr) {
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
			},
			data: payload,
			dataType: 'json',
		})
	})
}