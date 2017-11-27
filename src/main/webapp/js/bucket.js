$("#buy").bind("click", function (event, ui) {
    alert("Вы купили товары на сумму " + $("#general_price").val() + " руб.");
});

$(".delete").bind("click", function (event, ui) {
    $.ajax({
        url: "http://localhost:8080/deleteFromBucket/" + $(this).attr('id'),
        type: "POST",
        success: function(){
            location.reload();
        }
    });
});