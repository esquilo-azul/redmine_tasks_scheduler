require_dependency 'scheduled_tasks_controller'

module RedmineTasksScheduler
  module Patches
    module ScheduledTasksControllerPatch
      def self.included(base)
        base.class_eval do
          unloadable

          require_permission 'scheduled_tasks'
          layout 'redmine_tasks_scheduler'
        end
      end
    end
  end
end

unless ::ScheduledTasksController.included_modules.include?(
  ::RedmineTasksScheduler::Patches::ScheduledTasksControllerPatch)
  ::ScheduledTasksController.send(:include,
                                  ::RedmineTasksScheduler::Patches::ScheduledTasksControllerPatch)
end
