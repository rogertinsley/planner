module BacklogHelper
  def mark_button_as_primary(link_text, link_path)
    class_name = current_page?(link_path) ? 'btn btn-primary' : 'btn btn-default'
    link_to(link_text, link_path, class: class_name)
  end
end
