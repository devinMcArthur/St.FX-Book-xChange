module ApplicationHelper

  def full_title(page_title = '')
    base_title = "St.FX Exchange"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def link_to_add_fields(name, f)
    render 'book_prompt', f: f
    link_to(name, '#', class: "add_fields")
  end

end
