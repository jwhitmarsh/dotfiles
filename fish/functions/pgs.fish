# run `postgres service=db-alias`
# requires connection aliases saved in ~/.pg_service.conf
# example: `pgs db-alias-name`
# bonus: tab completion :)
function pgs
	if [ -z "$argv" ]
		echo "A connection alias is required!"
		return 1
	end

	if [ -z (command -v pgcli >/dev/null) ]
		set CLI pgcli
	else if [ -z (command -v psql >/dev/null) ]
		set CLI psql
	else
		echo "No postgres CLI tool found. Try pgcli or psql"
	end

	eval "$CLI service=$argv"
end
# pgs "$@"
