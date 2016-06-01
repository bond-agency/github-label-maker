require 'octokit'
require 'netrc'
require_relative 'functions'

# Do some printing.
printRuler()
puts "Logged in as: #{$bold}#{$user.login}#{$unbold}"
printRuler()
puts "Your repositories:"
printLineBreak()
printRepos()
printRuler()

# Store user actions.
action = ""

while (!action.eql? "Q") || (!action.eql? "q") do

  # Ask if user want's to update single or all repos?
  puts "You can quit the program by giving (Q) as action"
  puts "Do you want to edit issue labels for single (S) or all (A) repositories or quit (Q)?:"
  action = gets.chomp

  if (action.eql? "S") || (action.eql? "s")
    puts "Full name of the repository you want to edit (username/repository):"
    repo_full_name = gets.chomp
    printLineBreak()
    checkIfRepositoryExists(repo_full_name)
    createLabels(repo_full_name)
  elsif (action.eql? "A") || (action.eql? "a")
    repos = $client.repos()
    for repo in repos
      repo = repo.rels[:self].get.data
      puts "Creating labels for: #{$bold}#{repo.full_name}#{$unbold}"
      createLabels(repo.full_name)
      printRuler()
    end
  elsif (action.eql? "Q") || (action.eql? "q")
    #Quit.
    puts "Quiting..."
    exit
  else
    printCmdError()
    printLineBreak()
  end

end
