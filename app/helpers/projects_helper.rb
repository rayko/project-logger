module ProjectsHelper
  def project_last_updated_at(project)
    return '<i>No entries</i>'.html_safe unless project.entries.any?

    "Updated #{time_ago_in_words(project.entries.last.created_at)} ago"
  end

  def project_edited_at(project)
    "Edited #{time_ago_in_words(project.updated_at)} ago"
  end

  def project_created_at(project)
    "Created #{time_ago_in_words(project.created_at)} ago"
  end
end
