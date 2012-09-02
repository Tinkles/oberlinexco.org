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
    failures = []
    begin
      ActiveRecord::Base.transaction do
        CSV.foreach(args[:filename], headers: true, header_converters: :symbol) do |r|
          begin
            instructors = []
            (1..4).each do |i|
              instructor = r["instructor #{i}".parameterize.underscore.to_sym]
              instructors << instructor unless instructor.blank?
            end
            e = Exco.new(name: r[:course_name],
                         credits: r[:credit_hours],
                         course_number: r[:course_number],
                         instructed_by: instructors.join(", "),
                         enrollment_limit: r[:class_limit],
                         year: args[:year],
                         term: args[:term])
            e.save!
            success_counter += 1
            print '.'
          rescue Exception => e
            failures << e
            print 'F'
          end
        end
        puts ""
        puts failures.map{|e| "\nFailure: #{e.message}"}.join("\n")
        puts "" if failures.size > 0
        print "#{success_counter} successes, #{failures.size} failures\n"
        if failures.size > 0
          puts "NO ExCos were imported" if failures.size > 0
          raise Exception
        end
      end
    rescue Exception
    end
  end

end
