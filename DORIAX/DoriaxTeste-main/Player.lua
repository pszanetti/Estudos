local Player = {
    properties = {
        { name = "speed", displayName = "Speed", type = "float", default = 200.0 }
    }
}

function Player:init()
    RegisterEngineEvent(self, "onUpdate")
end

function Player:onUpdate()
    local obj = Object(self.scene, self.entity)
    local dt = Engine.deltatime
    local dx, dy = 0, 0

    if Input.isKeyPressed(Input.KEY_LEFT)  then dx = dx - self.speed * dt end
    if Input.isKeyPressed(Input.KEY_RIGHT) then dx = dx + self.speed * dt end
    if Input.isKeyPressed(Input.KEY_UP)    then dy = dy + self.speed * dt end
    if Input.isKeyPressed(Input.KEY_DOWN)  then dy = dy - self.speed * dt end

    -- Object.position is returned by value; assign the updated vector back.
    obj.position = obj.position + Vector3(dx, dy, 0)
end

return Player
