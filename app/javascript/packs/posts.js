document.addEventListener("turbolinks:load", function () {
    $(function(){
        var switchBtn = $('input[name="post[kind_of_practice]"]');
        var switchItems = $('.switchItems');
        var switchItems1 = $('.result-header > .time')
        var switchItems2 = $('.high')
        switchItems2.hide()
        switchBtn.on('change', function(){
            var inputValue = $(this).val();
            if (inputValue === "レスト"){
                switchItems.hide();
            }else if (inputValue === "インターバル" || inputValue === "レペティション"){
                switchItems.show();
                switchItems1.hide();
                switchItems2.show();
                $('.distance-text').text('[m]');
            }else{
                switchItems.show();
                switchItems1.show();
                switchItems2.hide();
                if (inputValue === "ジョグ" || inputValue === "距離走"){
                    $('.distance-text').text('[km]');
                }else{
                    $('.distance-text').text('[m]');
                }
            }
        });
    });
});