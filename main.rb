def findline(p1,p2)
    p1x=p1[0].to_f
    p1y=p1[1].to_f
    p2x=p2[0].to_f
    p2y=p2[1].to_f

    a1=(p1y-p2y)/(p1x-p2x)
    a0=(-1*p1x*a1)+p1y
    return [a0,a1]
end

def predict(datas)
    threshold=0.95
    srand(Time.now.to_i)

    while 1
        p1_i=rand(100)
        p2_i=rand(100)

        while p1_i==p2_i
            p2_i=rand(100)
        end

        p1=datas[p1_i]
        p2=datas[p2_i]

        line=findline(p1,p2)

        # prediction

        # p=0.95

        if p>=threshold
            break
        end
    end
end

def ransac()
    io=File.open("data_file/line_fit_sample_data_with_delimiter_blank.txt", "r")

    datas=[]

    while data=io.gets
        datas.append(data.split(" "))
    end

    predict(datas)
end

ransac()