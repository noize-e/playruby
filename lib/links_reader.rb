# frozen_string_literal: true

require 'prettyprint'

class Links
  def initialize(source)
    @source = source
  end

  def filter(word, exclude: [])
    filter_by(word)
    omit_by(exclude) unless exclude.empty?
    split_by_title
    self
  end

  def titles
    @titles.each_index.map(&1.method(:+)).zip(@titles)
  end

  private

  def filter_by(word)
    @links = @source.reject {|link| (link =~ /#{word}/i).nil?}
  end

  def omit_by(words)
    words.each {|w| @links.select! {|link| (link =~ /#{w}/i).nil?} }
  end

  def split_by_title
    @urls, @titles = @links.map {|i| i.split('|', 2).map(&:strip)}.transpose
  end
end
