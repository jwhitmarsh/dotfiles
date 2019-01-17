function __cache_or_get_cap_completion -d "Create cap completions"
	set -l cap_cache_file ".cap_taks~"

	if not test -f "$cap_cache_file"
    cap -T 2>&1 | grep "^cap" |cut -d " " -f 2 > "$cap_cache_file"
	end

	cat "$cap_cache_file"
end

function _get_cap_stage_completion -d "Create cap stage completions"
  find config/deploy -name \*.rb | cut -d/ -f3 | sed s:.rb::g
end

function _check_stage_not_set
  set cmd (commandline -op)

  if test (count $cmd) -lt 3
    and not contains -- $cmd[2] (_get_cap_stage_completion)
    return 0
  end

  return 1
end

function _check_stage_set
  set cmd (commandline -op)
  set -e cmd[1]

  test -z "$cmd"
  and return 1

  return 0
end

complete -x -c cap -n '_check_stage_not_set' -a "(_get_cap_stage_completion)"
complete -x -c cap -n '_check_stage_set' -a "(__cache_or_get_cap_completion)"
