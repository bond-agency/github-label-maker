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
  puts "Do you want to remove issue labels for single (S) or all (A) repositories?:"
  action = gets.chomp

  if (action.eql? "S") || (action.eql? "s")
    # Check which repo is being updated.
    puts "Select the repo you want to update:"
    repo_full_name = gets.chomp
    printLineBreak()
    checkIfRepositoryExists(repo_full_name)

    # Print all labels of the repo.
    puts "#{repo_full_name} labels:"
    printRepoLabels(repo_full_name)
    printLineBreak()

    # Ask which label should be removed.
    puts "Name of the label you want to remove:"
    labelname = gets.chomp
    printLineBreak()
    removeLabel(repo_full_name, labelname)
    printLineBreak()

  elsif (action.eql? "A") || (action.eql? "a")
    # Ask which label should be removed.
    puts "Name of the label you want to remove:"
    labelname = gets.chomp
    printLineBreak()
    repos = $client.repos()
    for repo in repos
      repo = repo.rels[:self].get.data
      removeLabel(repo.full_name, labelname)
    end
    printLineBreak()
  elsif (action.eql? "Q") || (action.eql? "q")
    # Quit.
    puts "Quiting..."
    exit

  else
    printCmdError()
    printLineBreak()
  end

end
