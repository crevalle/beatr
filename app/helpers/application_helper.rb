module ApplicationHelper
  def format_timestamp timestamp
    return '-' if timestamp.nil?
    timestamp.localtime.strftime '%D %r'
  end
end
