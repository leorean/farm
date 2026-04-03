for (var i = 0; i < array_length(bindings); i++)
{
    var btn      = bindings[i][0];
    var key      = bindings[i][1];
    var oldstate = input_state[i];
    
    var is_down  = keyboard_check(key);
    var was_down = (oldstate & InputState.HOLD) || (oldstate & InputState.PRESSED);
    
    var newstate = InputState.NAN;
    
    if (is_down)
    {
        if (!was_down)
            newstate = InputState.PRESSED;
        else
            newstate = InputState.HOLD;
    }
    else
    {
        if (was_down)
            newstate = InputState.RELEASED;
        else
            newstate = InputState.NAN;
    }
    
    input_state[i] = newstate;
}