module RedmineTasksScheduler
  module Hooks
    class AddAssets < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(_context = {})
        stylesheet_tag << javascript_tag <<
          stylesheet_link_tag(:application, plugin: 'redmine_tasks_scheduler') <<
          javascript_include_tag(:application, plugin: 'redmine_tasks_scheduler') <<
          init_alert
      end

      private

      def stylesheet_tag
        tag('link', media: 'all', rel: 'stylesheet', href: asset_path('assets/tasks_scheduler.css'))
      end

      def javascript_tag
        content_tag('script', ' ', src: asset_path('assets/tasks_scheduler.js'))
      end

      def init_alert
        raw(<<EOS)
<script>
  TasksScheduler.Alert.init('#{running_tasks_scheduler_daemon_path}', {
    element_selector: '.tasks-scheduler-alert'
  });
</script>
EOS
      end
    end
  end
end
