module ApplicationHelper
  def present(model, presenter_class = nil)
    defined_class = presenter_class || "#{model.class}Presenter".constantize
    presenter = defined_class.new(model, self)
    yield(presenter) if block_given?
  end
end
