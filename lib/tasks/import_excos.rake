require 'csv'

namespace :import_excos do

  desc <<-desc
    import ExCos from a file

    usage:
      rake import_excos:import[<filename>,<year>,<Fall|Spring>]
  desc
  task :import, [:filename, :year, :term] => :environment do |t, args|
    puts "importing from #{args[:filename]}"
    puts "Started"
    success_counter = 0
    failure_counter = 0
    failures = []
    CSV.foreach(args[:filename], headers: true, header_converters: :symbol) do |r|
      begin
        e = Exco.new(name: r[:course_name],
                     credits: r[:credit_hours],
                     course_number: r[:course_number],
                     enrollment_limit: r[:class_limit],
                     year: args[:year],
                     term: args[:term])
        e.save!
        success_counter += 1
        print '.'
      rescue Exception => e
        failures << e
        failure_counter += 1
        print 'F'
      end
    end
    puts ""
    puts ""
    failures.each_with_index do |e, i|
      puts "Failure: #{e.message}"
      puts ""
    end
    puts "#{success_counter} successes, #{failure_counter} failures"
  end

end
