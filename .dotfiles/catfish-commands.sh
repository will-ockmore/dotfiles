export CATFISH_HOSTNAME_OVERRIDE="localhost"

# test command for django projects (catfish - uses runtests)
alias ctest="NO_MIGRATIONS=true ctf project run -- runtests --keepdb"
alias ct="IN_TEST=true FILE_STORAGE='django.core.files.storage.FileSystemStorage' ctf project run manage.py -- test --keepdb"

ctp() {
  if [[ $@ == "start" ]]; then
      command ctf project start
  elif [[ $@ == "stop" ]]; then
      command ctf project stop
  elif [[ $@ == "restart" ]]; then
      command ctf project restart
  elif [[ $@ == "status" ]]; then
      command ctf project status
  elif [[ $@ == "stop" ]]; then
      command ctf project stop
  elif [[ $@ == "logs" ]]; then
      command ctf project logs
  elif [[ $@ == "what" ]]; then
      ctp stop && ctp start & ctp logs
  elif [[ $@ == "shell" ]]; then
      command ctf project run -- python manage.py shell
  elif [[ $@ == "migrate" ]]; then
      command ctf project run -- python manage.py migrate
  elif [[ $@ == "test" ]]; then
      command ctf project run -- runtests --keepdb
  else
      command ctf project "$@"
  fi
}
