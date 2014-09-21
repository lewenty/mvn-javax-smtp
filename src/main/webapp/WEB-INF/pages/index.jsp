<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>

    <%--bootstrap css--%>
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">

    <%--bootstrap js--%>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

    <%--jquery js--%>
    <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>

</head>
<body>
<style>

    .mailDiv {
        margin: 0px auto;
        margin-top: 10px;
        padding: 20px;
        width: 50%;
        border: 1px solid #000;
    }

</style>

<script>
    $(document).ready(function () {

        $("#btnFormPost").click(function () {

            var formValues = $("#mailForm").serialize();

            $.ajax({
                type: "post",
                dataType: "json",
                url: "http://localhost:8080/mail/send.htm",
                data: formValues,
                success: function (response) {

//                    alert(response["status"]);
                    $("#resFirstName").text(response["firstname"]);
                    $("#resLastName").text(response["lastname"]);
                    $("#resEmail").text(response["toMail"]);
                    $("#resStatus").text(response["status"]);
                },
                error: function () {
                    alert('Post İşlemi Esnasında Bir Hata Oluştu');
                }//error finish
            });//ajax finish
        });//click finish

    });
</script>

<div class="mailDiv">
    <form role="form" id="mailForm" method="POST" onsubmit="return false;">
        <div class="form-group">
            <input type="text" class="form-control" name="firstname" id="firstname" placeholder="Ad">
        </div>

        <div class="form-group">
            <input type="text" class="form-control" name="lastname" id="lastname" placeholder="Soyad">
        </div>
        <div class="form-group">
            <input type="email" class="form-control" id="email" name="email" placeholder="E-Posta">
        </div>

        <div class="form-group">
            <input type="password" class="form-control" id="password" name="password" placeholder="Sifre">
        </div>

        <div class="form-group">
            <input type="text" class="form-control" id="subject" name="subject" placeholder="Konu">
        </div>

        <div class="form-group">
            <textarea class="form-control" rows="3" name="message"></textarea>
        </div>
        <button type="submit" id="btnFormPost" class="btn btn-primary">Gonder</button>
    </form>
</div>

<div class="mailDiv" id="result">
    <div class="form-group">
        <label>Adı : </label>
        <label id="resFirstName"></label>
    </div>
    <div class="form-group">
        <label>Soyadı : </label>
        <label id="resLastName"></label>
    </div>
    <div class="form-group">
        <label>E-Posta : </label>
        <label id="resEmail"></label>
    </div>
    <div class="form-group">
        <label> Durumu : </label>
        <label id="resStatus"></label>
    </div>
</div>

</body>
</html>
