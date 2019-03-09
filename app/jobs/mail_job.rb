class MailJob < ApplicationJob
  queue_as :urgent

  def perform(klass_name, method_name, *args)
    klass_name.to_s.constantize.send(method_name.to_sym, *args).deliver_now
  end
end
