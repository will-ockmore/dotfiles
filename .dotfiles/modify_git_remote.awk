{
if (match($2, /git@.*:axomic\/(.*)\.git/, groups))
    # If within axomic repository, use work account
    printf "git@github-work:axomic/%s.git", groups[1] 
else if (match($2, /git@.*:(.*)\.git/, groups))
    # Any other repository should use personal account
    printf "git@github-personal:%s.git", groups[1] 
}
