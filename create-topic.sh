#! /usr/bin/env bash

target_path="$(pwd)/src/topics"

run() {
  read -p "topic directory name (replace spaces with dashes): " topic_name

  topic_dir="${target_path}/${topic_name}"

  mkdir "$topic_dir"

  create_topic_files
}

create_topic_files() {
  declare -a file_types=(index walkthrough studio)

  for file_type in "${file_types[@]}"
  do
    create_topic_file $file_type
  done

  create_topic_file objectives 'Learning Objectives'
}

create_topic_file() {
  file_type="$1"

  file_header="$2"

  if [[ -z $file_header ]]; then
    IFS= read -p "enter the header for the ${file_type} doc: " file_header
  fi

  cat << EOF > "${topic_dir}/${file_type}.rst"
:orphan:

.. _${topic_name}_${file_type}

$(print_header_border "$file_header")
${file_header}
$(print_header_border "$file_header")

EOF
}

print_header_border() {
  file_header_length="${#1}"

  printf '=%.0s' $(seq $file_header_length)
}

run
