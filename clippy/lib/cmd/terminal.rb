# frozen_string_literal: true

# Commandline Terminal class
class Terminal

  def self.input(label)
    print label
    $stdin.gets.chomp
  end

  def self.system_open(url, label: nil)
    p label unless label.nil?
    # grep by regex search the key match and call the corresponing os open lambda
    commands.fetch(commands.keys.grep(/#{host}/).first)[url]
  end

  def self.host
    # Get the system host release, remove the versioning, e.g. 'darwin15.0.0' => 'darwin'
    # Tests:
    #   - Mac OS X 10.11 El Capitan
    @host ||= Regexp.new(RbConfig::CONFIG['host_os'].gsub(/[0-9]+\.?+/, ''))
  end

  def self.commands
    {
      'mswin-mingw-cygwin': ->(x) { system "start #{x}" },
      'darwin': ->(x) { system "open #{x}" },
      'linux-bsd': ->(x) { system "xdg-open #{x}" }
    }
  end
end