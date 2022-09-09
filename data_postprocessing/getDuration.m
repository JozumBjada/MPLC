function [hour, min, sec] = getDuration(dursec)
% retrieve number of hours, minutes and seconds from the total number of
% seconds
% dursec - total number of seconds

    sec  = mod(dursec,60);
    min  = mod((dursec - sec)/60, 60);
    hour = ((dursec - sec)/60 - min)/60;

end