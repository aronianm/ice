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