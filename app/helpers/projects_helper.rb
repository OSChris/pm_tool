module ProjectsHelper

  def next_page page, pages
    page += 1 if page < pages - 1
  end

  def previous_page page
    page -= 1 if page > 0
  end

  def offset_count
    @projects.count + fancy_offset
  end

  def more_pages
    offset_count > 10
  end

  def hide_next
    @page + 1 > @pages - 1
  end

  def hide_previous
    @page - 1 < 0
  end

  def fancy_offset
    @page.to_i * 10
  end
end
