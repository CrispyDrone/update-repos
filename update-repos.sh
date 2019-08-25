# $1 = root directory, $2 = remote, $3 = branch names, $4 = ff only, $5 = regex 
# set -e

# constants
get_repository_name_regex='^.+\/\(.*\)\.git$'

# variables
root_directory="${1:-.}"
remote="${2:-origin}"
IFS=',' read -ra branches <<< "${3:-master}" 
ff_only="${4:-true}"
repository_name_regex="${5:-.*}"

# verify variables
# echo "${root_directory}"
# echo "${remote}"
# echo "${branches[@]}"
# echo "${ff_only}"

# functions
elementIn()
{
	local toSearch element
	toSearch="${1}"
  	shift
  	for element; do [[ "$element" == "$toSearch" ]] && return 0; done
  	return 1
}

# script
cd ${root_directory}
echo "changed to directory ${root_directory}"

for folder in */
do
	cd "${folder}"
	echo "changed to directory $folder"

	IFS='' read -ra existing_remotes <<< $(git remote)

	echo "${existing_remotes[@]}"

	if ! elementIn "${remote}" "${existing_remotes[@]}"
	then
		echo "${remote} does not exist!"
		echo "Skipping this repository."
		cd "${root_directory}"
		continue;
	fi

	remote_url=$(git remote get-url "${remote}")
	repository_name=$(echo "${remote_url}" | sed 's/'"${get_repository_name_regex}"'/\1/')

	# echo "${remote_url}"
	# echo "${repository_name}"

	shopt -s nocasematch

	if [[ ! ${repository_name} =~ ${repository_name_regex} ]]
	then
		echo "Skipping ${repository_name} since it does not match the given regex ${repository_name_regex}"
		cd "${root_directory}"
		continue;
	fi

	shopt -u nocasematch

	echo 'fetching new content for '"${remote_url}"
	git fetch --tags --prune "${remote_url}" "${branches[@]}"

	if [[ ! $? -eq 0 ]]
	then
		echo "One or multiple branches of ${branches[@]} were not found on the remote."
		echo "Skipping this repository."
		cd "${root_directory}"
		continue;
	fi

	for branch in "${branches[@]}"
	do
		echo "checking out branch $branch"
		git checkout "${branch}"

		if [[ "${ff_only}" = true ]]
		then
			echo "fast foward merging with ${remote}/${branch}"
			git merge --ff-only "${remote}"/"${branch}"
		else
			echo "merging with ${remote}/${branch}"
			git merge "${remote}"/"${branch}"
		fi
	done

	cd "${root_directory}"
done

