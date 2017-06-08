# coding: utf-8

require 'redmine'
require 'active_scaffold'
ActiveScaffold.delayed_setup = true

Redmine::Plugin.register :redmine_tasks_scheduler do
  name 'Redmine Tasks Scheduler'
  author 'eduardobogoni@gmail.com'
  description 'Scheduler for rake tasks on Redmine.'
  version '0.0.1'
end

Rails.configuration.to_prepare do
  GroupPermission.add_permission('scheduled_tasks')
  require_dependency 'redmine_tasks_scheduler/patches/tasks_scheduler_controller_patch'
  require_dependency 'redmine_tasks_scheduler/hooks/add_assets'
  Redmine::MenuManager.map :admin_menu do |menu|
    menu.push :scheduled_tasks, { controller: 'tasks_scheduler_daemon', action: 'index', id: nil },
              caption: :'activerecord.models.scheduled_task.other',
              if: proc { GroupPermission.permission?('scheduled_tasks') }
  end
end
