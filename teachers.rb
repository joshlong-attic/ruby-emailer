def main(args)

  def write_teachers_csv(path, rows)
    require 'csv'
    csv_file = File.open(path, 'w')
    CSV.open(csv_file.path, "w") do |csv|
      rows.each do |row|
        result = yield row
        csv << result
      end
    end
  end

  def write_teachers_emails(rows)
    rows.each do |row|
      subject, email, name = row
      first_name, last_name = name.split(' ')
      email, email_body = yield subject, email, first_name, last_name
      puts email
      puts
      puts email_body
    end


  end

  the_file = File.new(File::join([ENV['HOME'], 'Desktop', 'teachers', 'teachers.md']))
  if the_file.lstat.file?
    rows = the_file.readlines
               .filter { |x| !x.start_with?('#') }
               .map { |line| line.split('|').map { |l| l.strip! } }

    write_teachers_csv(File::join([ENV['HOME'], 'Desktop', 'teachers', 'teachers.csv']), rows) do |row|
      subject, email, name = row
      [subject, email, name]
    end

    write_teachers_emails(rows) do
    |subject, email, first, last|

      email_body = <<-EMAIL


      EMAIL

      [email, email_body]
    end


  end
end

if __FILE__ == $PROGRAM_NAME
  main(ARGV)
end