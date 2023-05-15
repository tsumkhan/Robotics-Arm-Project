function determineExtrinsics()
    % Make Pipeline object to manage streaming
    pipe = realsense.pipeline();
    
    % Start streaming on an arbitrary camera with default settings
    profile = pipe.start();

    % Extract the color and depth streams
    color_stream = profile.get_stream(realsense.stream.color).as('video_stream_profile');
    depth_stream = profile.get_stream(realsense.stream.depth).as('video_stream_profile');
    
    % Get and display the intrinsics
    Tdc = depth_stream.get_extrinsics_to(color_stream);
    x = Tdc.rotation;
    y = Tdc.translation;
    hom_trans = [x(1:3) y(1);
                 x(4:6) y(2);
                 x(7:9) y(3);
                 0 0 0 1]
end