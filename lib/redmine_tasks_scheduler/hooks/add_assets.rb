module RedmineTasksScheduler
  module Hooks
    class AddAssets < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(_context = {})
        safe_join([stylesheet_tag,
                   stylesheet_link_tag(:application, plugin: 'redmine_tasks_scheduler'),
                   tasks_scheduler_javascript_tag,
                   javascript_include_tag(:application, plugin: 'redmine_tasks_scheduler'),
                   init_alert])
      end

      private

      def stylesheet_tag
        tag('link', media: 'all', rel: 'stylesheet', href: asset_path('assets/tasks_scheduler.css'))
      end

      def tasks_scheduler_javascript_tag
        content_tag('script', "\n", src: asset_path('assets/tasks_scheduler.js'))
      end

      def init_alert
        javascript_tag(<<EOS)
  TasksScheduler.Alert.init({
    element_selector: '.tasks-scheduler-alert'
  });
EOS
      end
    end
  end
end
