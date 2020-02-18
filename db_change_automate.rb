puts 'Enter db_dump path : '
 	db_dump = gets.chomp
 	if !db_dump.empty?
	 	system("pg_restore -l #{db_dump} > restore.pgdump.list")
		file_string = File.read("restore.pgdump.list")
		File.open("restore.pgdump.list", "w") {|file| file.puts file_string}
		system("pg_restore --verbose --clean --no-acl --no-owner -h localhost -U rails -d sprint_dev 11022020 -L ../sprint/sprint/restore.pgdump.list")
	end
