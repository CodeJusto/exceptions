require 'date'

def find(id)
  raise '@candidates must be an array' if @candidates.nil?
  @candidates.detect {|applicant| applicant[:id] == id}
end

def apply_date?(candidate)
  today = Date.today
  today - candidate[:date_applied] <= 15 ? true : false
end

def experienced?(candidate)
  unless candidate.has_key?(:years_of_experience)
    raise ArgumentError, 'Candidate must have a :years_of_experience key'
  end
  candidate[:years_of_experience] > 2 
end

def github?(candidate)
  candidate[:github_points] > 100 
end

def languages?(candidate)
  candidate[:languages].include?("Ruby"||"Python") 
end

def age?(candidate)
  candidate[:age] > 17
end

def qualified_candidates
  applicant = @candidates.select do |recruit|
    experienced?(recruit) &&
    github?(recruit)&&
    languages?(recruit)&&
    apply_date?(recruit) == true &&
    age?(recruit)
  end
  applicant.sort! do |a,b|
  sorted = b[:years_of_experience] <=> a[:years_of_experience]
  if sorted == 0
    b[:github_points] <=> a[:github_points]
  else
    sorted
  end
end
  applicant.each do |qualified|
    puts "Applicant ##{qualified[:id]} is qualified. She has #{qualified[:years_of_experience]} years of experience, #{qualified[:github_points]} Github points, is proficient in #{qualified[:languages].join(", ")}, is #{qualified[:age]}, and applied on #{qualified[:date_applied]}."
  end
end

# def ordered_by_qualifications 
#   @candidates.sort do |a,b|
#     sorted = b[:years_of_experience] <=> a[:years_of_experience]
#     if sorted == 0
#       b[:github_points] <=> a[:github_points]
#     else
#       sorted
#     end
#   end
# end

