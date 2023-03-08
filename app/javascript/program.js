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
}
