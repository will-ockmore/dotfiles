{
if ($2 ~ /git@.*:axomic\/(.*)\.git/)
    # If within axomic repository, use work account
    print GIT_GPG_SIGNING_KEY_WORK
else 
    # Any other repository should use personal account
    print GIT_GPG_SIGNING_KEY_PERSONAL
}
