# $1 = root directory, $2 = ff only, $3 = branch names
set -e
cd $1

for folder in */
do
	cd "${folder}"
	echo "in folder $folder"

	remote_url=$(git remote get-url origin)
	echo 'fetching new content for '"${remote_url}"

	git fetch --all --tags --prune

	IFS=',' read -ra branches <<< "$3" 

	for branch in "${branches[@]}"
	do
		echo "checking out branch $branch"
		git checkout "${branch}"

		if [[ "${2}" == 'true' ]]
		then
			echo "fast foward merging with origin/$branch"
			git merge --ff-only origin/"${branch}"
		else
			echo "merging with origin/$branch"
			git merge origin/"${branch}"
		fi
	done
done
