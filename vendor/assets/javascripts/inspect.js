function InspectTemplates()
{
    this.enable = function(){
        var bar = $('<div class="inspect-top"><a href="javascript:void(0)" class="bar">INSPECT</a></div>');
        $(document.body).append(bar);

        $('.inspect-top').live('click',function(e){

            e.stopPropagation();

            if($('.inspect').hasClass('active'))
                $('.inspect').removeClass('active')
            else
                $('.inspect').addClass('active')
        });
    }
    this.disable = function(){
        $('.inspect-top').hide();
        $('.inspect').removeClass('active')
    }

}

var __INSPECT__ = new InspectTemplates();


$(function(){
    if(window.location.href.indexOf("__inspect__") != -1){
        __INSPECT__.enable()
    }
})
