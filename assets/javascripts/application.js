_A = TasksScheduler.Alert

_A.refresh = function () {
  $.ajax({
    url: _A.url,
    global: false,
    success: function (result) {
      var alert = $(_A.options.element_selector);
      if (result === 'true') {
        alert.hide();
      } else {
        alert.show();
      }
    },
    complete: function (result) {
      _A.setNextRefresh();
    }
  });
};
