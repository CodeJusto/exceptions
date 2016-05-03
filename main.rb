# This is the main entrypoint into the program
# It requires the other files/gems that it needs

require 'pry'
require './candidates'
require './filters'
require 'pp'

## Your test code can go here

# binding.pry

# puts experienced?(@candidates[0])
# p find(5)
# p find(25)
# pp qualified_candidates_sup
# pp qualified_candidates
# pp ordered_by_qualifications
def candidate_to_s(applicant)
  "The ID if this applicant is #{applicant[:id]}, she has #{applicant[:years_of_experience]} years of experience, #{applicant[:github_points]} Github points, is proficient in #{applicant[:languages].join(", ")}, is #{applicant[:age]}, and applied on #{applicant[:date_applied]}."
end

selection = ""
while selection != "quit"
  puts "What do you want to do?"
  selection = gets.chomp.downcase
  if selection =~ (/^find\s\d+/)
    id = selection.slice(5..-1).to_i
    applicant = find(id)
    unless applicant == nil
      puts candidate_to_s(applicant)
    else
      puts "That person does not exist."
    end
  elsif selection == "all"
    @candidates.each do |applicant|
      puts candidate_to_s(applicant) 
    end
  elsif selection == "qualified"
    qualified_candidates
  end 
end

    