$(".work-btn").find("li").eq("0").click(function () {
    $(".tap").css("display", "none");
    $(".profile-tap").css("display", "block");
});
$(".work-btn").find("li").eq("1").click(function () {
    $(".tap").css("display", "none");
    $(".work-tap").css("display", "block");
});
$(".work-btn").find("li").eq("2").click(function () {
    $(".tap").css("display", "none");
    $(".search-tap").css("display", "block");
});

$(".seoul-lt").click(function () {
    $(".map").css("background", "url('img/lefttop.png')no-repeat center");
//    $(".map").css("background-position", "-37px -54px");
});
$(".seoul-lb").click(function () {
    $(".map").css("background", "url('img/leftbot.png')no-repeat center");
//    $(".map").css("background-position", "-37px -54px");
});
$(".seoul-rt").click(function () {
    $(".map").css("background", "url('img/righttop.png')no-repeat center");
//    $(".map").css("background-position", "-37px -54px");
});
$(".seoul-rb").click(function () {
    $(".map").css("background", "url('img/rightbot.png')no-repeat center");
//    $(".map").css("background-position", "-37px -54px");
});
$(".seoul-mb").click(function () {
    $(".map").css("background", "url('img/righmid.png')no-repeat center");
//    $(".map").css("background-position", "-37px -54px");
});


$(".work-mid").find("li").eq(8).click(function(){
    $(".work-bot").find("li").css("display","block");
    $(".plus").css("display","block");
});