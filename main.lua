hoc = require("hoc")

function pong()
    ball_xv = ball_xv * -1
end

function ceiling()
    ball_yv = ball_yv * -1
end

function wall()
    ball_x = 400
    ball_y = 450
    if ball_xv == -10 then
        r_score = r_score + 1
    else
        l_score = l_score + 1
    end
end

function love.load()
    love.graphics.setBackgroundColor( 0, 0, 0)
    --ball
    ball_x = 400
    ball_y = 450
    ball_xv = 10
    ball_yv = 10
    --paddles
    rect_y = 200
    l_rect_x = 10
    r_rect_x = 780
    rect_w = 10
    rect_h = 100
    rect_v = 7
    --health/score
    health = 5
    l_score = 0
    r_score = 0
    --top/bottom walls
    ceiling_x = 0
    t_ceiling_y = 0
    b_ceiling_y = 590
    ceiling_w = 800
    ceiling_h = 10
    --borders
    l_border_x = 0
    r_border_x = 790
    border_y = 0
    border_w = 10
    border_h = 600
    --paddle/ball collisions
    collide = hoc( 100, pong )
    l_rect_p = collide:addRectangle( l_rect_x, rect_y, rect_w, rect_h )
    r_rect_p = collide:addRectangle( r_rect_x, rect_y, rect_w, rect_h )
    f_ball_p = collide:addRectangle( ball_x, ball_y, 10, 10 )
    --top/bottom wall collision
    bounce = hoc( 100, ceiling )
    t_ceiling_p = bounce:addRectangle( ceiling_x, t_ceiling_y, ceiling_w, ceiling_h )
    b_ceiling_p = bounce:addRectangle( ceiling_x, b_ceiling_y, ceiling_w, ceiling_h )
    s_ball_p = bounce:addRectangle( ball_x, ball_y, 10, 10 )
    --side/side collision
    border = hoc( 100, wall )
    l_border = border:addRectangle( l_border_x, border_y, border_w, border_h )
    r_border = border:addRectangle( r_border_x, border_y, border_w, border_h )
    t_ball_p = border:addRectangle( ball_x, ball_y, 10, 10 )
end

function love.draw()
    love.graphics.setBackgroundColor( 0, 0, 0)
    --Graphics
    love.graphics.setBackgroundColor( 0, 0, 0)
    love.graphics.setColor( 255, 255, 255, 255 )
    --paddles
    l_rect = love.graphics.rectangle( "fill", l_rect_x, rect_y, rect_w, rect_h )
    r_rect = love.graphics.rectangle( "fill", r_rect_x, rect_y, rect_w, rect_h )
    --ball
    m_ball = love.graphics.rectangle( "fill", ball_x, ball_y, 10, 10 )
    --center line
    m_line = love.graphics.rectangle( "fill", 395, 0, 10, 610 )
    --ceilings
    t_ceiling = love.graphics.rectangle( "fill", ceiling_x, t_ceiling_y, ceiling_w, ceiling_h )
    b_ceiling = love.graphics.rectangle( "fill", ceiling_x, b_ceiling_y, ceiling_w, ceiling_h )
    love.graphics.setColor(255,0,0)
    t_ceiling_p:draw("line")
    b_ceiling_p:draw("line")
    --borders
    l_border:draw("fill")
    love.graphics.setColor(0, 0, 255)
    r_border:draw("fill")
    --lifes
    --love.graphics.setNewFont(12)
    lifes = love.graphics.print( "Lifes: " .. health, 450, 0, 0, 1, 1)
    love.graphics.setColor(255,0,0)
    --l_rect_p:draw("line")
    --r_rect_p:draw("line")
    --f_ball_p:draw("line")
    --score
    --love.graphics.setNewFont(74)
    love.graphics.print( l_score, 100, 100, 0, 1, 1 )
    love.graphics.print( r_score, 700, 100, 0, 1, 1 )
end

function love.update(dt)
    ball_x = ball_x + ball_xv
    ball_y = ball_y + ball_yv
    l_rect_p:moveTo(l_rect_x+(rect_w/2), rect_y+(rect_h/2))
    r_rect_p:moveTo(r_rect_x+(rect_w/2), rect_y+(rect_h/2))
    f_ball_p:moveTo(ball_x+5, ball_y+5)
    s_ball_p:moveTo(ball_x+5, ball_y+5)
    t_ball_p:moveTo(ball_x+5, ball_y+5)
    collide:update(dt)
    bounce:update(dt)
    border:update(dt)
    up = love.keyboard.isDown('w')
    down = love.keyboard.isDown('s')
    if up and rect_y >= 10 then
        rect_y = rect_y - rect_v
    elseif down and rect_y+rect_h <= 590 then
        rect_y = rect_y + rect_v
    end
end

function love.keypressed( key )
end
