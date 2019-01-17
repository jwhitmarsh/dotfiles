set -l completions

for line in (cat $HOME/.pg_service.conf)
  if string match -q -r '\[' $line
    set completions "$completions (echo $line | sed 's/[][]//g')"
  end
end
echo $completions

complete -c pgs -a $completions -f -A
