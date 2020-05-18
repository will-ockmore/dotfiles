{
if ($2 ~ /git@.*:axomic\/(.*)\.git/)
    # If within axomic repository, use work account
    print "will.ockmore@axomic.com"
else if ($2 ~ /git@.*:(.*)\.git/)
    # Any other repository should use personal account
    print "will.ockmore@gmail.com"
}
