function TasksScheduler() {
}

TasksScheduler.Status = function () {
}

// Shortcut
var _S = TasksScheduler.Status;

_S.initialized = false;

_S.init = function (url, interval_max) {
  if (!_S.initialized) {
    _S.initialized = true;
    _S.url = url;
    _S.interval_max = interval_max;
    _S.update();
  }
};

_S.content = function () {
  return $('#TaskScheduler_Status_Content');
};

_S.status = function () {
  return $('#TaskScheduler_Status_Status');
};

_S.update_status = function () {
  _S.status().html(
    "Updating in " + _S.interval + " seconds..."
  );
};

_S.check = function () {
  if (_S.interval <= 0) {
    _S.update();
  } else {
    _S.interval--;
    _S.update_status();
    setTimeout(_S.check, 1000);
  }
};

_S.update = function () {
  $.ajax({
    url: _S.url,
    success: function (result) {
      _S.content().html(result);
    },
    complete: function (result) {
      _S.interval = _S.interval_max + 1;
      _S.last_update = new Date();
      _S.check();
    }
  });
};

TasksScheduler.Alert = function () {
};

_A = TasksScheduler.Alert;

_A.DEFAULT_REFRESH_INTERVAL = 60000;
_A.DEFAULT_ELEMENT_SELECTOR = '#tasks_scheduler_alert';
_A.url = null;

_A.init = function (url, options = {}) {
  $(document).ready(function () {
    _A.url = url;
    _A.options = options;
    if (!_A.options.refresh_interval) {
      _A.options.refresh_interval = _A.DEFAULT_REFRESH_INTERVAL;
    }
    if (!_A.options.element_selector) {
      _A.options.element_selector = _A.DEFAULT_ELEMENT_SELECTOR;
    }
    _A.refresh();
  });
};

_A.setNextRefresh = function () {
  setTimeout(_A.refresh, _A.options.refresh_interval);
};

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
