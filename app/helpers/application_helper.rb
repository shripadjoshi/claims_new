module ApplicationHelper
  def generate_common_links(hash)
    html = ""
    #html += link_to('Export To Excel', hash[:index_path]) + " | " if hash[:object].present?
    html += link_to(hash[:create_text], hash[:create_path])
    return html.html_safe
  end
end
