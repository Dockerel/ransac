io=File.open("data_file/line_fit_sample_data_with_delimiter_blank.txt", "r")

x=[]
y=[]

while data=io.gets
    d=data.split(" ")
    x.append(d[0].to_f)
    y.append(d[1].to_f)
end

data_length=x.length

n_iteration=1000000
threshold=0.5

best_model=[]
max_inliers=0

for i in 0...n_iteration
    srand(Time.now.to_i)
    random_indices=[rand(0...100),rand(0...100)]
    while random_indices[0]==random_indices[1]
        random_indices=[rand(0...100),rand(0...100)]
    end

    sample_x=[x[random_indices[0]],x[random_indices[1]]]
    sample_y=[y[random_indices[0]],y[random_indices[1]]]

    slope=(sample_y[1]-sample_y[0])/(sample_x[1]-sample_x[0])
    intercept=sample_y[0]-slope*sample_x[0]

    distance=[]
    inliers=0
    for j in 0...data_length
        d=(y[j]-(slope*x[j]+intercept)).abs
        distance.append(d)
        if d<threshold
            inliers+=1
        end
    end

    if inliers>max_inliers
        max_inliers=inliers
        best_model=[slope,intercept]
    end
end

puts "slope : "
puts best_model[0]
puts "intercept : "
puts best_model[1]
puts "inliers : "
puts max_inliers
