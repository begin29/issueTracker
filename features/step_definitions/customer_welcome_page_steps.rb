Given(/^I am viewing "(.*?)"$/) do |page|
  visit path_to page
end

Then(/^I should see a button with a value of "(.*?)"$/) do |arg1|
  page.has_button?(arg1)
end

When(/^I follow "(.*?)"$/) do |page|
  visit path_to page
end

When(/^I fill in "(.*?)" named "(.*?)" with "(.*?)"$/) do |arg1, arg2, arg3|
  e = find("#{arg1}[id$='#{arg2.downcase.gsub(' ', '_')}']")
  e.set arg3
end

When(/^I press "(.*?)"$/) do |button|
  click_button button
end

When(/^I click "(.*?)"$/) do |link|
  click_link link
end

Then(/^I should be on the page with the "(.*?)" message "(.*?)"$/) do |class_arg, text|
  page.should have_css(".#{class_arg.downcase.gsub(' ', '-')}", text: text)
end

Then(/^customer with email "(.*?)" should receive message with subject 'Your request on site "(.*?)" was created!' and ticket link with format "(.*?)"$/) do |email, subject, expression|
  @email = ActionMailer::Base.deliveries.first
  @email.from.first.should == "test_sender@example.com"
  @email.to.first.should == email
  @email.subject.should include(subject)
  @email.body.match(expression).should_not be_blank
end

Given(/^exist customer "(.*?)" with requested email$/) do |email|
  @user = FactoryGirl.create(:user, email: email)
  @ticket = FactoryGirl.create(:ticket, customer_id: @user.id)
  UserMailer.request_email(@user.id, @ticket.id).deliver_now
end

Given(/^I follow to ticket show page by link with format "(.*?)" from email$/) do |expression|
  @email = ActionMailer::Base.deliveries.first
  res = Regexp.new(expression).match(@email.body.raw_source)
  @ticket = Ticket.friendly.find(res[0])
  visit path_to "show ticket #{@ticket.slug}"
end

