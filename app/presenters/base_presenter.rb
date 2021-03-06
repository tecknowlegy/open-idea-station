class BasePresenter < SimpleDelegator
  def initialize(model, view)
    @model = model
    @view = view
    super @model
  end

  def current_view
    @view
  end

  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { rel: "nofollow", target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true,
    }

    extensions = {
      autolink: true,
      superscript: true,
      disable_indented_code_blocks: true,
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  private

  # Defers to the view if possible.
  def method_missing(*args, &block)
    if current_view.respond_to?(args.first)
      current_view.send(*args, &block)
    else
      return if args.first.to_s.end_with? "_link"

      super
    end
  end

  def respond_to_missing?(method, include_private = false)
    current_view.respond_to?(method) || super
  end
end
