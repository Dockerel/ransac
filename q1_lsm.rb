io=File.open("data_file/line_fit_sample_data_with_delimiter_blank.txt", "r")

x=[]
y=[]

while data=io.gets
    d=data.split(" ")
    x.append(d[0].to_f)
    y.append(d[1].to_f)
end

data_length=x.length

mean_x=x.sum/data_length
mean_y=y.sum/data_length

numerator = 0
denominator = 0

for i in 0...data_length
  numerator+=(x[i]-mean_x)*(y[i]-mean_y)
  denominator+=(x[i]-mean_x**2)
end

slope=numerator/denominator
intercept=mean_y-slope*mean_x

puts "slope : "
puts slope
puts "intercept : "
puts intercept
