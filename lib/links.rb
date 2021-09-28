# frozen_string_literal: true

# Links reader class
class Links
  attr_reader :title, :url

  def initialize(source)
    @source = source
  end

  def filter(word, exclude: [])
    filter_by(word)
    omit_by(exclude) unless exclude.empty?
    split_by_title
    self
  end

  def print_titles
    @titles.each_with_index { |v, i| p "[#{i + 1}] #{v}" }
  end

  def select_url(id)
    self.title = id
    self.url = id
    # Returning self allow to call tap method, e.g,
    # links.select_url(2).tap { |s| p s.title }
    # => "ID 2 Website URL Title"
    self
  end

  def title=(id)
    @title = @titles[(id - 1)]
  end

  def url=(id)
    @url = @urls[(id - 1)]
  end

  private

  def filter_by(word)
    @links = @source.reject { |link| (link =~ /#{word}/i).nil? }
  end

  def omit_by(words)
    words.each { |w| @links.select! { |link| (link =~ /#{w}/i).nil? } }
  end

  def split_by_title
    @urls, @titles = @links.map { |i| i.split('|', 2).map(&:strip) }.transpose
  end
end
