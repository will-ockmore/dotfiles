# tee is required because of wierd indentation bug
alias dctp="docker-compose run catfish /catfish/env/bin/ctf project"
alias dshell="tee | docker-compose run catfish /catfish/env/bin/ctf project run manage.py shell"
alias dct="tee | docker-compose run catfish /catfish/env/bin/ctf project run manage.py -- test --keepdb"
