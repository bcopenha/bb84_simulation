function me = measure(x) %Outputs a 1x1 matrix
    M = 1000000;
    me = ([1 0]*x).^2;
    for i=1:length(me)
        m = randi(M); %might need to go from 0 to M but this function does 1 to M
        if m < round(me(i),2)*M
            me(i) = 0;
        else
            me(i) = 1;
        end
    end
end