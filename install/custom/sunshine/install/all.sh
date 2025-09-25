declare -a files=(
  packages
  openssh
  lock_screen
  sunshine
  enable_wol
)

source_dir=$(dirname ${BASH_SOURCE[0]})

for file in "${files[@]}"; do
  run_logged $source_dir/$file.sh
done
