function [right_motor, left_motor]  = line_follow(right, middle, left, mode, speed, scanspeed)
persistent time 
if ~exist ("time","var")
time = 0;
end

if mode == 1
    if left == 0 && middle == 1 && right == 0
        %Straight
        right_motor = speed;
        left_motor = speed;
    elseif left == 1 && middle == 1 && right == 0
        %RightSlight
        right_motor = speed;
        left_motor = speed/2;
    elseif left == 1 && middle == 0 && right == 0
        %Right
        right_motor = speed;
        left_motor = -speed;
    elseif left == 0 && middle == 1 && right == 1
        %LeftSlight
        right_motor = speed/2;
        left_motor = speed;
    elseif left == 0 && middle == 0 && right == 1
        %Left
        right_motor = speed;
        left_motor = -speed;
    else     %scanning
        time = time + 1;
        if time < scanspeed %change to time off
            %scan right
            left_motor = scanspeed;
            right_motor = -scanspeed;
        elseif time >= scanspeed && time < 30 %change to time off
            %scan left
            left_motor = -scanspeed;
            right_motor = scanspeed;
        elseif time >= 30 && time < 40  %change to time off
            left_motor = scanspeed;
            right_motor = -scanspeed;
        else
            left_motor = -scanspeed;
            right_motor = -scanspeed;
        end
    end
end