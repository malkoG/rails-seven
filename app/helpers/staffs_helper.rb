module StaffsHelper
  def header_helper
    page = "staffs/header"
    page = @header if @header.present?
    page = "staffs/header" if session[:staff_header] == "taeri"
    page
  end

  def sort_field_for(q, field_name, default_order: :asc)
    ordering_rule = params.dig("q", "s") || ""
    ordering_field, ordering = ordering_rule.split

    caret_direction = default_order == :asc ? "up" : "down"

    status = "deactivated"
    if ordering_field == field_name.to_s
      status = "activated" if caret_direction == "up" && ordering == "asc"
      status = "activated" if caret_direction == "down" && ordering == "desc"
    end

    icon_html = <<~html
      <i class="ui icon caret #{caret_direction} big #{status}">
      </i>
    html

    sort_link q, field_name, default_order: default_order do
      icon_html.html_safe
    end
  end

  def sortable_header(q, field, name)
    html = <<~HTML
      #{name}

      #{sort_field_for(q, field, default_order: :asc)}
      #{sort_field_for(q, field, default_order: :desc)}
    HTML

    html.html_safe
  end
end
