module ApplicationHelper
  def format_timestamp timestamp
    return '-' if timestamp.nil?
    timestamp.strftime '%D %r'
  end
end
