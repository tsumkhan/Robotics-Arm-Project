function determineIntrinsics()
    % Make Pipeline object to manage streaming
    pipe = realsense.pipeline();
    
    % Start streaming on an arbitrary camera with default settings
    profile = pipe.start();

    % Extract the color stream
    color_stream = profile.get_stream(realsense.stream.color).as('video_stream_profile');
    color_stream_IR = profile.get_stream(realsense.stream.depth).as('video_stream_profile');
    
    % Get and display the intrinsics
    color_intrinsics = color_stream.get_intrinsics()
    color_intrinsics_IR = color_stream_IR.get_intrinsics()

end