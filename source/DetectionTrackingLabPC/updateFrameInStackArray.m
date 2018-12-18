function tri_frames = updateFrameInStackArray(tri_frames, currentFrame)
    tri_frames(:, :, 1) = tri_frames(:, :, 2);
    tri_frames(:, :, 2) = tri_frames(:, :, 3);
    tri_frames(:, :, 3) = currentFrame;
end