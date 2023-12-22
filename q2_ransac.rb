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

n_iteration=1000000
threshold=7

best_model=[]
max_inliers=0

for i in 0...n_iteration
    srand(Time.now.to_i)
    sample_x=[]
    sample_y=[]
    sample_z=[]
    vec1=[]
    vec2=[]
    while 1
        random_indices=[rand(0...data_length),rand(0...data_length),rand(0...data_length)]
        sample_x=[x[random_indices[0]],x[random_indices[1]],x[random_indices[2]]]
        sample_y=[y[random_indices[0]],y[random_indices[1]],y[random_indices[2]]]
        sample_z=[z[random_indices[0]],z[random_indices[1]],z[random_indices[2]]]

        vec1=[sample_x[0]-sample_x[1],sample_y[0]-sample_y[1],sample_z[0]-sample_z[1]]
        vec2=[sample_x[0]-sample_x[2],sample_y[0]-sample_y[2],sample_z[0]-sample_z[2]]

        if vec1[0]/vec2[0]!=vec1[1]/vec2[1] || vec1[1]/vec2[1]!=vec1[2]/vec2[2]
            break
        end
    end

    normal_vector = [
        vec1[1] * vec2[2] - vec1[2] * vec2[1],
        vec1[2] * vec2[0] - vec1[0] * vec2[2],
        vec1[0] * vec2[1] - vec1[1] * vec2[0]
    ]

    plane_d=normal_vector[0]*sample_x[0]+normal_vector[1]*sample_y[0]+normal_vector[2]*sample_z[0]

    distance=[]
    inliers=0
    for j in 0...data_length
        d=(z[j]+((normal_vector[0]*x[j]+normal_vector[1]*y[j]+plane_d)/normal_vector[2])).abs
        distance.append(d)
        if d<threshold
            inliers+=1
        end
    end

    if inliers>max_inliers
        max_inliers=inliers
        best_model=[normal_vector,plane_d]
    end
end

puts "normal_vector : #{best_model[0][0]}, #{best_model[0][1]}, #{best_model[0][2]}"
puts "plane_d : "
puts best_model[1]
puts "inliers : "
puts max_inliers
