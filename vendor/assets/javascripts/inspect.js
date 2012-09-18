function InspectTemplates()
{
    this.enable = function(){
        var bar = $('<div class="inspect-top"><a href="javascript:void(0)" class="bar">INSPECT</a></div>');
        $(document.body).append(bar);


        $('.inspect-top').live('click',function(e){

            e.stopPropagation();
             /**
            if($('.inspect').hasClass('active'))
                $('.inspect').removeClass('active')
            else
                $('.inspect').addClass('active')
             **/
            var zIndex=2147483647;
            var hall=$("#hall")
            if(hall.length == 0)
            {
               hall = $('<div id="hall">');
               $(document.body).append(hall);

                $('.inspect').each(function(i,el){
                    var w=$(el).parent();
                    var o=w.offset();
                    var border=$('<div>')
                        .attr('class','inspect-template '+$(this).data('render'))
                        .css('top',o.top)
                        .css('left',o.left)
                        .css('width',w.outerWidth())
                        .css('height',w.outerHeight())
                        .css('z-index',zIndex)

                    border.attr("data-path",$(this).data("path"));
                    border.attr("data-render",$(this).data("render"));
                    $(hall).append(border)
                });
                return;
            }
            if(hall.is(":visible"))
            {
                $("#hall").remove();
            }

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
