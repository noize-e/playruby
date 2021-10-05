# frozen_string_literal: true

require './lib/cmd/terminal'

dirpath = Terminal.input('Directory[?]: ').to_s

dircontents = Dir["#{dirpath}/*"]
dircontents.each { |subdir| p Dir["#{subdir}/*"] }