function [ u ] = membresiabis( alpha, lambda, pixel )
beta=(alpha+lambda)/2;
if(pixel<alpha)
    u=0;
else if ((pixel <= beta) && (pixel>= alpha))
        u=2*((pixel-alpha)/(lambda-alpha))^2;
    else if ((pixel <= lambda) && (pixel>= beta))
             u=1-2*((pixel-lambda)/(lambda-alpha))^2;
        else if (pixel>lambda)
                u=1;
            end
        end
    end
end


end

