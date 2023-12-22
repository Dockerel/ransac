io=File.open("data_file/plane_fit_sample_data_with_delimiter_blank.txt", "r")

x=[]
y=[]
z=[]

while data=io.gets
    d=data.split(" ")
    x.append(d[0].to_f)
    y.append(d[1].to_f)
    z.append(d[2].to_f)
end

data_length=x.length

sum_x = x.sum
sum_y = y.sum
sum_z = z.sum
sum_x_sq = x.map { |i| i**2 }.sum
sum_y_sq = y.map { |i| i**2 }.sum
sum_z_sq = z.map { |i| i**2 }.sum
sum_xy = x.zip(y).map { |xi, yi| xi * yi }.sum
sum_xz = x.zip(z).map { |xi, zi| xi * zi }.sum
sum_yz = y.zip(z).map { |yi, zi| yi * zi }.sum

n = data_length.to_f
a = (n * sum_xz - sum_x * sum_z) / (n * sum_x_sq - sum_x**2)
b = (n * sum_yz - sum_y * sum_z) / (n * sum_y_sq - sum_y**2)
c = (sum_z - a * sum_x - b * sum_y) / n
d = sum_z_sq - a * sum_xz - b * sum_yz - c * sum_z

puts "normal_vector : #{a}, #{b}, #{c}"
puts "plane_d : "
puts d
