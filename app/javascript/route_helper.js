$.fn.routeHelper = function(){
    $("a[data-remote]").each(function(){
        var init = $(this).attr('init')
        if(init === undefined){
            $(this).attr('init', true)
            var url =  this.href
            var target = $(this).data('target')
            this.href = "#"
            // history.pushState("turbo", '', url)

            $(this).on('click', function(){

                $.ajax({
                    url: url,
                    success: function(data){
                        this.href = url
                        $(document).routeHelper()
                    }
                })
            })
        }
    })
}