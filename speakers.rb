if __FILE__ == $0

  class String
    def split_lines ()
      self.split(/\n+|\r+/).reject(&:empty?)
    end
  end

  class Speaker
    attr_accessor :first, :last, :email, :topics

    def initialize (first, last, email, topics)
      @first = first
      @last = last
      @email = email
      @topics = topics
    end
  end


  speakers = Array.new

  def convert_template (email, first_name, topics)
    greetings = "Hi #{first_name}, "
    body = %{
   this is the body of the email with interpolated variables like #{email}.
  }
               .strip
               .lstrip
               .split_lines
               .map { |x| x.strip }
               .join

    sig = %{
Thanks,
Josh Long
Spring Developer Advocate
VMWare
    }.strip

    %{
hopefully there's something so pithy in the subject that you are compelled to respond
    }

  end

  def map_line_to_speakers (line)
    name, email, topics = line.split('|')
    first, last = name.split(' ')
    Speaker.new first.strip, last.strip, email.strip, topics.strip
  end

  ctr = 0

  %{
        First1 Last1 |	 fl1@some-company.io | topics one, and two
        First2 Last2 |	 fl2@some-company.io | topics three, and four

  }
      .strip
      .split_lines()
      .map { |line| map_line_to_speakers(line) }
      .map { |speaker| convert_template(speaker.email, speaker.first, speaker.topics) }
      .each do |body|
    ctr += 1

    File.open("#{ENV['HOME']}/Desktop/email-#{ctr}.md", "w+") { |ptr| ptr.write(body) }
  end

end