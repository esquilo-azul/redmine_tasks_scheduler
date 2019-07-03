module RedmineTasksScheduler
  module Hooks
    class AddAssets < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(_context = {})
        safe_join([stylesheet_tag,
                   stylesheet_link_tag(:application, plugin: 'redmine_tasks_scheduler'),
                   javascript_include_tag(:application, plugin: 'redmine_tasks_scheduler'),
                   init_alert])
      end

      private

      def stylesheet_tag
        tag('link', media: 'all', rel: 'stylesheet', href: asset_path('assets/tasks_scheduler.css'))
      end

      def init_alert
        javascript_tag(<<EOS)
  TasksScheduler.Alert.init('#{status_tasks_scheduler_daemon_path}', {
    element_selector: '.tasks-scheduler-alert'
  });
EOS
      end
    end
  end
end
