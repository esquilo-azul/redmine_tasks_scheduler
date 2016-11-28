# coding: utf-8

require 'redmine'
require 'active_scaffold'
ActiveScaffold.delayed_setup = true

Redmine::Plugin.register :redmine_tasks_scheduler do
  name 'Redmine Tasks Scheduler'
  author 'eduardobogoni@gmail.com'
  description 'Scheduler for rake tasks on Redmine.'
  version '0.0.1'

  Redmine::MenuManager.map :admin_menu do |menu|
    menu.push :scheduled_tasks, { controller: 'scheduled_tasks', action: 'index', id: nil },
              caption: :'activerecord.models.scheduled_task.other',
              if: proc { GroupPermission.permission?('scheduled_tasks') }
  end
end

Rails.configuration.to_prepare do
  GroupPermission.add_permission('scheduled_tasks')
  require 'redmine_tasks_scheduler/patches/scheduled_tasks_controller_patch'
end
