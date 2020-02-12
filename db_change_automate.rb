puts 'Enter db_dump path : '
 	db_dump = gets.chomp
 	if !db_dump.empty?
	 	system("pg_restore -l #{db_dump} > restore.pgdump.list")
		file_string = File.read("restore.pgdump.list")
		tables_to_skip = [
			"6141; 0 469414 TABLE DATA public callback_requests u6c5bashfvjh0k",
			"6284; 0 469993 TABLE DATA public remote_requests u6c5bashfvjh0k",
			"6288; 0 470009 TABLE DATA public resync_requests u6c5bashfvjh0k",
			"6337; 0 470201 TABLE DATA public versions u6c5bashfvjh0k",
			"6344; 0 762497 TABLE DATA public resync_remote_requests u6c5bashfvjh0k"
		]
		replaced_string = file_string
		tables_to_skip.each do |table|
			replaced_string = replaced_string.to_s.gsub(table,'')
		end

		File.open("restore.pgdump.list", "w") {|file| file.puts replaced_string}
		system("pg_restore --verbose --clean --no-acl --no-owner -h localhost -U rails -d sprint_dev 11022020 -L ../sprint/sprint/restore.pgdump.list")
	end


