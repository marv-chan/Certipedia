
Given /the following certificates exist/ do |course_table|
  course_table.hashes.each do |course|
    Certificate.create course
  end
end

When /I (un)?check the following schools: (.*)/ do |uncheck, school_list|
  list = school_list.split(', ')
  list.each do |element|
	  if(uncheck)
		 uncheck("schools_"+element)
	  else
		 check("schools_" +element)
	  end
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

Then /(.*) seed certificates should exist/ do | n_seeds |
  Certificate.count.should be n_seeds.to_i
end

Given /Given I log in as admin/ do
   
end
