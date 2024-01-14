def converter
	puts "Select folder"
	system("ls")
	puts "Folder name: "
	folder = gets.chomp
	puts "These are the files"
	items = `ls #{folder}`.split(" ")

	uniq_exts = analyze_extensions(items)
	files = check_files_for_converting(uniq_exts,items)
	new_folder = create_directory(folder)
	convert_files(new_folder,folder,files)
end

def analyze_extensions(items)
	extensions = items.map {|item| item.split(".").pop}
	uniq_exts = extensions.uniq!
	return uniq_exts
end

def check_files_for_converting(uniq_exts,items)
	non_raw_extensions = ["JPG", "png"]
	#show extensions
	convertable_files = items.select {|item| uniq_exts.include?(item.split(".").pop)}
	puts "Files im about to convert... #{convertable_files}"
	return convertable_files
end


#create directory
def create_directory(folder)
	time = Time.new
	new_folder = "#{folder}/converted_files/#{time.usec}"
	#create folder
	system("mkdir -p #{new_folder}")
	return new_folder
end

def convert_files(new_folder,folder,files)
	files.each do |file|
		 old_file = File.join(folder, file)
		 new_format_file = file.gsub(".NEF", ".jpg")
		 new_file = File.join(new_folder, new_format_file)
		 puts "#{new_file}"
		system("convert #{old_file} #{new_file}")
	end
	puts "Done..."
end

#runs the program
converter



