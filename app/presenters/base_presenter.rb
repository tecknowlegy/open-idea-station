class BasePresenter < SimpleDelegator
  def initialize(model, view)
    @model, @view = model, view
    super @model
  end

  def current_view
    @view
  end
end
