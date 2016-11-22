# coding: utf-8

require 'redmine'

Redmine::Plugin.register :redmine_tasks_scheduler do
  name 'Redmine Tasks Scheduler'
  author 'eduardobogoni@gmail.com'
  description 'Scheduler for rake tasks on Redmine.'
  version '0.0.1'
end
