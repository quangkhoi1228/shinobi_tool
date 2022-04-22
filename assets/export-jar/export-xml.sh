# export project_name=$project_name
# export project_dir=$project_dir
# export workspace=$workspace
# export main_class=$main_class
# export output_dir=$output_dir

export current_path="$PWD"
cd $project_dir 

export xml_file_name=build_${project_name}.xml
rm $output_dir/$project_name.jar
brew install maven

brew install ant

#create dependency list file 
#maven jar
export dependency_list_file_name=${project_name}_dependency_list.csv
mvn dependency:build-classpath -Dmdep.outputFile=$output_dir/$dependency_list_file_name
sed -i -e 's/:/\'$'\n''/g' $output_dir/$dependency_list_file_name

#other jar
declare -a  project_jar_directory_dependencies1=$project_jar_directory_dependencies
for file in "${project_jar_directory_dependencies1[@]}"
do
    echo "\n$file" >> $output_dir/$dependency_list_file_name
done


# create 
export jar_file_in_lib_folder_class_path=""
export jar_file_in_user_maven_folder_class_path=""
while read line; 
do
    # reading each line
    jar_file_name=`basename -- "$line"`
    jar_file_in_user_maven_folder_class_path+="\n<copy file=\"$line\" todir=\"\${dir.jarfile}/${project_name}_lib\"/>"
    jar_file_in_lib_folder_class_path+=" ${project_name}_lib/$jar_file_name"
done < $output_dir/$dependency_list_file_name


cat $output_dir/template.xml > $output_dir/$xml_file_name

sed -i -e 's/\${{project_name}}/'${project_name}'/g' $output_dir/$xml_file_name
sed -i -e 's/\${{main_class}}/'${main_class}'/g' $output_dir/$xml_file_name
sed -i -e "s|\${{workspace}}|${workspace}|g" $output_dir/$xml_file_name
sed -i -e "s|\${{jar_file_in_lib_folder_class_path}}|${jar_file_in_lib_folder_class_path}|g" $output_dir/$xml_file_name
sed -i -e "s|\${{jar_file_in_user_maven_folder_class_path}}|${jar_file_in_user_maven_folder_class_path}|g" $output_dir/$xml_file_name
sed -i -e "s|\${{project_dir}}|${project_dir}|g" $output_dir/$xml_file_name




cd $output_dir

ant -f $xml_file_name


echo "done"


rm $output_dir/$xml_file_name-e
rm $output_dir/export-jar-file.command
rm $output_dir/template.xml
rm $output_dir/$dependency_list_file_name
rm $output_dir/$dependency_list_file_name-e
