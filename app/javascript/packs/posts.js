document.addEventListener("turbolinks:load", function () {
    $(function(){
        var switchOption = $('[name="post[kind_of_practice]"]');
        // var switchItems = $('.switchItems');
        // var switchItems1 = $('.result-header > .time')
        // var switchItems2 = $('.high')
        // switchItems2.hide()
        switchOption.on('change', function(){
            var option = $('[name="post[kind_of_practice]"]').val();
            if (option === "レスト"){
                // switchItems.hide();
            }else if (option === "インターバル" || option === "レペティション"){
                // switchItems.show();
                // switchItems1.hide();
                // switchItems2.show();
                $('.distance-text').text('m');
            }else{
                // switchItems.show();
                // switchItems1.show();
                // switchItems2.hide();
                if (option === "ジョグ" || option === "距離走"){
                    $('.distance-text').text('km');
                }else{
                    $('.distance-text').text('m');
                }
            }
        });
    });
});
$(function(){
    var switchOption = $('[name="post[kind_of_practice]"]');
    switchOption.on('change', function(){
        var option = $('[name="post[kind_of_practice]"]').val();
        if (option==="ビルドアップ") {
            $('.distance-text').text('m');
        }else{
            $('.distance-text').text('km');
        }
    });
});


