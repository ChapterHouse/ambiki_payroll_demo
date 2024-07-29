module ApplicationHelper
  def datalist(id, input, choices = {}) #, options = {}, html_options = {}) #, &block)
    content_tag(:datalist, nil, id: id) do
      choices.map do |text, value|
        content_tag(:option, text, value: value, data: { id: "#{input}_#{value}" }) # , value: value, 'autocomplete-input-target' => input
      end.join.html_safe
    end
  end
end
