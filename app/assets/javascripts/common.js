$( document ).ready(function() {

    $(".cb-enable").on("click", function(){
        $(".dvLoading").show();
        var clicked_object = $(this);
        var parent = $(this).parents('.switch');
        $.ajax({
            url: '/users/'+$(this).parent().attr("id")+'/status',
            type : "PUT",
            success: function(data) {
                $('.cb-disable',parent).removeClass('selected');
                $(clicked_object).addClass('selected');
                $(".dvLoading").hide();
            }
        });
    });

    $(".cb-disable").on("click", function(){
        $(".dvLoading").show();
        var clicked_object = $(this);
        var parent = $(this).parents('.switch');
        $.ajax({
            url: '/users/'+$(this).parent().attr("id")+'/status',
            type : "PUT",
            success: function(data) {
                $('.cb-enable',parent).removeClass('selected');
                $(clicked_object).addClass('selected');
                $(".dvLoading").hide();
            }
        });
    });

//Document.ready ends
});
