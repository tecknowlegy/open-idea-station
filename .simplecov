SimpleCov.start do
   add_filter 'app/channels'
   add_filter 'app/jobs'
   add_filter 'app/mailers'
   add_filter 'app/views'
   add_filter 'app/controllers/application_controller.rb'
   add_filter 'app/controllers/notifications_controller.rb'
   add_filter 'app/controllers/category_controller.rb'
   add_filter 'api/'
   add_filter 'app/services/acorn.rb'
   add_filter 'app/models/concerns/unique_identifier.rb'
   add_filter 'app/models/comment'
   add_filter 'lib/acorn/cable_broadcast.rb'
end