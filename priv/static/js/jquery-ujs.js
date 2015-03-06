$(function () {
  $("a[data-remote]").click(function (e) {
    e.preventDefault();

    var $this = $(this);

    if ($this.attr("data-confirm") !== undefined) {
      var c = confirm("Are you sure?");

      if (c !== true) {
        return;
      }
    }

    var href = $this.attr("href");
    var method = $this.attr("data-method");
    var csrfToken = $("#_csrf_token").attr("content");

    var $form = $("<form method='POST' action='"+href+"'></form>");
    var $methodInput = $("<input type='hidden' name='_method' value='"+method+"' />");
    var $csrfInput = $("<input type='hidden' name='_csrf_token' value='"+csrfToken+"' />");

    $form.hide().append($methodInput).append($csrfInput).appendTo("body");
    $form.submit();
  });
});
