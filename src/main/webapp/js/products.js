$(".add").bind("click", function (event, ui) {
    var isAdd = confirm("Добавить товар в корзину?");
    if(isAdd)
        $.ajax({
            url: "http://localhost:8080/addToBucket/" + $(this).attr('id'),
            type: "POST",
            success: function(){
                alert("Товар добавлен в корзину");
            }
        });
});

$(".delete").bind("click", function (event, ui) {
    $.ajax({
        url: "http://localhost:8080/deleteProduct/" + $(this).attr('id'),
        type: "POST",
        success: function(){
            location.reload();
        }
    });
});