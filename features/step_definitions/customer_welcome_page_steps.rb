Given(/^I am viewing "(.*?)"$/) do |arg1|
  visit path_to arg1
end

Then(/^I should see a button with a value of "(.*?)"$/) do |arg1|
  page.has_button?(arg1)
end

When(/^I follow "(.*?)"$/) do |page|
  visit path_to page
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When(/^I press "(.*?)"$/) do |link|
  click_link link
end

Then(/^I should see "(.*?)"$/) do |arg1|
  # TODO: this doesn`t work
  page.has_content?(arg1)
end

Then(/^customer should receive an email with ticket link$/) do
  pending # express the regexp above with the code you wish you had
end
