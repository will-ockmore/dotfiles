{
if ($2 ~ /git@.*:axomic\/(.*)\.git/)
    # If within axomic repository, use work account
    print "C91C04974128001D"
else if ($2 ~ /git@.*:(.*)\.git/)
    # Any other repository should use personal account
    print "9BEA8964EAAFC4AD"
}
