require 'json'

# Settings & login
$bold = "\033[1m"
$unbold = "\033[0m"

puts "\nStarting..."
$client = Octokit::Client.new(:netrc => true, :netrc_file => ".netrc", :per_page => 100)
$user = $client.user
$user.login





# Print all organizations repositories.
def printRepos()
  repos = $client.repos()
  for repo in repos
    puts repo.full_name
  end
end





# Prints repositorys labels
def printRepoLabels(repo_full_name)
  labels = $client.labels(repo_full_name)
  for label in labels
    puts label.name
  end
end





# Create labels for organization.
def createLabels(repo_full_name)

  file = File.read('labels.json')
  data = JSON.parse(file)

  for labeltype in data["labelTypes"]

    color = labeltype["color"]
    type = labeltype["type"]

    for label in labeltype["labels"]
      name = type + ": " + label["name"]
      createLabel(repo_full_name, name, color)
    end

  end

end





# Create single label for orranization.
def createLabel(repo_full_name, labelname, labelcolor)
  # First try to update. If the label is not found, create one.
  begin
    $client.update_label(repo_full_name, labelname, {:color => labelcolor})
    puts "Label #{$bold}#{labelname}#{$unbold} updated with color #{$bold}#{labelcolor}#{$unbold}"
  rescue Octokit::NotFound
    $client.add_label(repo_full_name, labelname, labelcolor)
    puts "Label #{$bold}#{labelname}#{$unbold} created with color #{$bold}#{labelcolor}#{$unbold}"
  end

end





# Remove label.
def removeLabel(repo_full_name, labelname)
  $client.delete_label!(repo_full_name, labelname)
  puts "Deleted label: #{$bold}#{labelname}#{$unbold} from #{repo_full_name}"
end





# Check that the repository exists.
def checkIfRepositoryExists(repo_full_name)
  if $client.repository?(repo_full_name) == false
    puts "Repository doesn't exist!"
    exit
  end
end





# Prints horizontal ruler
def printRuler()
  printLineBreak()
  puts "-------------------------------------------------"
  printLineBreak()
end





# Prints error which says that user has used wrong command
def printCmdError()
  puts "You gave some weird command captain!"
end





# Print linebreak
def printLineBreak()
  puts "\n"
end
