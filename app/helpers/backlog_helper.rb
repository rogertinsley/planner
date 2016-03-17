module BacklogHelper

  def format_github_repository string
    string.slice((string.index('/') + 1)..string.length)
  end
end
