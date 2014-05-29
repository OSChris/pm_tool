module ProjectsHelper

  def next_page page, pages
    page += 1 if page < pages - 1
  end

  def previous_page page
    page -= 1 if page > 0
  end
end
