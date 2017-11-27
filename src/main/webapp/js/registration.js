$("#registration").bind("click", function (event, ui) {
    if($("#password").val() != $("#password_2").val()){
        $("#error").append("Пароли не совпадают");
        return false;
    }
});