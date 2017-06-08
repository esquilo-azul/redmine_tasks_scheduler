module RedmineTasksScheduler
  class Settings
    class << self
      def daemon_autostart
        ::Setting.plugin_redmine_tasks_scheduler[:daemon_autostart] == '1'
      end
    end
  end
end
