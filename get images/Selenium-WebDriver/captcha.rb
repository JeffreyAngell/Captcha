require 'rubygems'
require 'selenium-webdriver'
require 'chunky_png'

driver = Selenium::WebDriver.for :chrome
driver.get "https://accounts.google.com/ServiceLoginAuth"

element = driver.find_element :name => "Email"
element.send_keys "Person@gmail.com"
i = 0;
array = 0;
for j in 1..1000
	puts j
	begin
		element = driver.find_element :name => "Passwd"
		element.send_keys "gogogo#{i}"
		element.submit
		array = driver.find_elements :tag_name, "img"
		i += 1
	end while array.size == 4

	imageurl = array[2].attribute("src")
	substring = imageurl[-30..-1]
	puts substring

	wd = Dir.pwd
	saveloc = "#{wd}/captcha-#{substring}.png"
	driver.save_screenshot(saveloc)

	input = ChunkyPNG::Image.from_file(saveloc)
	input.crop!(420, 460, 180, 60)
	input.save(saveloc)
end
