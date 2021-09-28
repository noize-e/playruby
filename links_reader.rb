# frozen_string_literal: true

require './lib/cmd/terminal'
require './lib/links'

search_param = Terminal.input('Search[e.g. docker]: ').to_s

links = Links.new(File.open('resources/bookmarks.txt').readlines)
links.filter(search_param)
links.print_titles

id = Terminal.input('ID[?]: ').to_i

links.select_url(id).tap do |lk|
  Terminal.system_open(lk.url, label: "Opening... #{lk.title}")
end
