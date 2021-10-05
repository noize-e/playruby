# frozen_string_literal: true

require 'prettyprint'
require 'set'

def hostname(url)
  unless (url = url[/(http[s]?):\/\/(\w+\.+)(\w+\.+)?[a-z]{1,4}/i]).nil?
    return url.gsub!(/(http[s]?):\/\//i, '')
  end
end

hosts = ARGF.readlines.inject([]) do |arr, link|
  url, title = link.split('|')
  unless url.nil? or (host = hostname(url)).nil?
    # (h[host] = h.fetch(host, [])) << { title => url  }
    arr << host
  end
  arr
end

pp hosts.uniq