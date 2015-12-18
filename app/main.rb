require_relative '../app/models/politician'

def first_question(state)
	puts "Senators:"
	@politicians = Politician.select(:firstname, :lastname, :party).where(title: 'Sen', state: state).order(:lastname)
	@politicians.each do |p|
		puts "	#{p.firstname} #{p.lastname} (#{p.party})"
	end

	puts ""
	puts "Representatives:"
	@politicians = Politician.select(:firstname, :lastname, :party).where(title: 'Rep', state: state).order(:lastname)
	@politicians.each do |p|
		puts "	#{p.firstname} #{p.lastname} (#{p.party})"
	end
	# puts "Senators:"
	# SELECT first_name, last_name, (party)
	# FROM politicians
	# WHERE title='Sen' AND state='#{input}'
	# ORDER BY last_name

	# puts "Representatives:"
	# SELECT first_name, last_name, party
	# FROM politicians
	# WHERE title='Rep' AND state='#{input}'
	# ORDER BY last_name
end

# first_question('NY')

def second_question(gender)
	
	count_sen = Politician.where(gender: gender, in_office: 1, title: 'Sen').count
	count_sen_percent = count_sen * 100 /(Politician.where(in_office: 1, title: 'Sen').count)
	if gender == 'M'
		a = 'Male'
	else
		a = 'Female'
	end

	puts "#{a} Senators: #{count_sen} (#{count_sen_percent}%)"

	count_rep = Politician.where(gender: gender, in_office: 1, title: 'Rep').count
	count_rep_percent = count_rep * 100 /(Politician.where(in_office: 1, title: 'Rep').count)
	if gender == 'M'
		b = 'Male'
	else
		b = 'Female'
	end

	puts "#{b} Representatives: #{count_rep} (#{count_rep_percent}%)"

	# SELECT gender, title, COUNT(title), COUNT(title) * 100 / (SELECT COUNT(gender) 		FROM politicians WHERE gender='#{input}')
	# FROM politicians
	# WHERE gender='#{input}' AND title='Sen' AND in_office=1

	# SELECT gender, title, COUNT(title), COUNT(title) * 100 / (SELECT COUNT(gender) 		FROM politicians WHERE gender='#{input}')
	# FROM politicians
	# WHERE gender='#{input}' AND title='Rep' AND in_office=1
end

# second_question('M')

def third_question
	state = Politician.group(:state).order("count_title desc").count("title")
	state.each do |k,v|
		b = Politician.where("state = ?",k).group(:title).count(:title)
		p "#{k}: #{b["Sen"]} Senators, #{b["Rep"]} Representative(s)"
	#Representative is the value, b is the key because when group and count go together, they become HASH. 
	end
	# SELECT states, COUNT(title)
	# FROM politicians
	# WHERE in_office = 1
	# ORDER BY title DESC
end

# third_question

def fourth_question
	sen = Politician.where(title: 'Sen').count
	rep = Politician.where(title: 'Rep').count

	puts "Senators: #{sen}"
	puts "Representatives: #{rep}"
end

# fourth_question

def fifth_question
	sen = Politician.delete_all(title: 'Sen', in_office: 0)
	remaining_sen = Politician.where(title: 'Sen').count

	rep = Politician.delete_all(title: 'Rep', in_office: 0)
	remaining_rep = Politician.where(title: 'Rep').count
	
	puts "Senators: #{remaining_sen}"
	puts "Representatives: #{remaining_rep}"
end

# fifth_question