let currentItem = undefined

$(window).ready(function () {
    window.addEventListener('message', function (event) {
        let data = event.data
        if (data.toggle) {
            $("body").fadeIn()
            $('.cat').html(addcat(data.cat))
            $('.itemss').html(additem(data.items))
            $('.creditAmount').html(data.creditamount)
            addMat(data.items)
        }

        function addcat(cat) {
            let html = '<b>'
            let catData = JSON.parse(cat)

            for (let i = 0; i < catData.length; i++) {
                html += '<button class="incat" style="width:fit-content; margin-right: 10px; height: 40px;" data-thecat="' + catData[i].catid + '">' + catData[i].label + '</button>'
            }
            html += '</b>'
            return html
        }

        function additem(items) {
            let html = ''
            let itemData = JSON.parse(items)

            for (let i = 0; i < itemData.length; i++) {
                html += '<div class="col-2 m-2 item cat-' + itemData[i].catid + '" data-id="' + i + '">'
                html += '<img class="item-img img-' + i + '" src="img/' + itemData[i].name + '.png" alt="" height=128px width=128px>'
                html += '<div class="item-desc desc-' + i + '"><p style="font-size: 20px;"><b>' + itemData[i].label + '</b></p>'
                html += '<button class="wear ' + itemData[i].name + '" data-item="' + itemData[i].name + '" data-itemname="' + itemData[i].label + '"><i class="fa-solid fa-pen-ruler"> buy</i></button></div></div>'
            }
            return html
        }

        function addMat(items) {
            let html = ''
            let itemData = JSON.parse(items)

            for (let i = 0; i < itemData.length; i++) {
                $('.'+itemData[i].name).data('credit', itemData[i].credit)
                }
            return html
        }
        

        $('.item').hover(function () {
            let a = $(this).data('id')
            $('.desc-' + a).css('opacity', 1);
            $('.img-' + a).css('opacity', 0);
        }, function () {
            let a = $(this).data('id')
            $('.desc-' + a).css('opacity', 0);
            $('.img-' + a).css('opacity', 1);
        })


        $("[type='number']").keypress(function (evt) {
            evt.preventDefault();
        })

        $('.wear').click(function () {
            let itemname = $(this).data('itemname')
            let mat = $(this).data('credit')
            let credit = '<p><b>' + mat + 'x </b><span class="infoitem"><img src="img/credit.png" alt=""height=42px width=42px>Credits</span></p>'
            currentItem = $(this).data('item')
            $('.items').css('display', 'none');
            $('.info').css('display', 'block');
            $('.back').css('display', 'block');
            $('.cat').css('display', 'none');
            $('.matlist').html(credit);
            $('.infoname').html(itemname);
            $(".info-img").attr("src", "img/" + currentItem + ".png");
        })

        $('.back').click(function () {
            $('.info').css('display', 'none');
            $('.items').css('display', 'block');
            $('.cat').css('display', 'block');
            $('input').val(1);
            $(this).css('display', 'none');
        })

        $('.incat').click(function () {
            let isActive = $(this).hasClass('active');
            let thecat = $(this).data('thecat');
            if (!isActive) {
                $('.active').removeClass('active');
                $(this).addClass('active');
                $('.item').css('display', 'none');
                $('.cat-' + thecat).css('display', 'block');
            } else {
                $(this).removeClass('active');
                $('.item').css('display', 'block');
            }
        })
    })

    $('.doit').click(function () {
        var count = $(".buy-count").val();
        $('.info').css('display', 'none');
        $('.items').css('display', 'block');
        $('.cat').css('display', 'block');
        $('.back').css('display', 'none');
        $('input').val(1);
        $("body").fadeOut()
        $.post('https://7Credits/buy', JSON.stringify({ Item: currentItem, Count: count }));
    })
    document.onkeyup = function (data) {
        if (data.keyCode == 27) {
            $('.info').css('display', 'none');
            $('.items').css('display', 'block');
            $('.cat').css('display', 'block');
            $('.back').css('display', 'none');
            $('input').val(1);
            $("body").fadeOut()
            $.post('https://7Credits/close', '{}');
        }
    }
})
