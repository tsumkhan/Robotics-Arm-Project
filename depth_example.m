function depth_example()
% Make Pipeline object to manage streaming
pipe = realsense.pipeline();
% Make Colorizer object to prettify depth output
colorizer = realsense.colorizer();

    % Start streaming on an arbitrary camera with default settings
    profile = pipe.start();

    % Get streaming device's name
    dev = profile.get_device();
    name = dev.get_info(realsense.camera_info.name);

    % Get frames. We discard the first couple to allow
    % the camera time to settle
    for i = 1:5
        fs = pipe.wait_for_frames();
    end
    
    % Stop streaming
    pipe.stop();

    % Select depth frame
    color = fs.get_color_frame();
    % Colorize depth frame
    %color = colorizer.colorize(depth);

    % Get actual data and convert into a format imshow can use
    % (Color data arrives as [R, G, B, R, G, B, ...] vector)
    data = color.get_data();
    img = permute(reshape(data',[3,color.get_width(),color.get_height()]),[3 2 1]);

    %data2 = get_color_frame();
    %img2 = permute(reshape(data2',[3,color.get_width(),color.get_height()]),[3 2 1]);


    % Display image
    imshow(img);%,img2,"montage");
    title(sprintf("Colorized depth frame from %s", name));
endfunction [outputArg1,outputArg2] = untitled(inputArg1,inputArg2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = inputArg1;
outputArg2 = inputArg2;
end