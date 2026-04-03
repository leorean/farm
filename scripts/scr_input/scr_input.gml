function get_btn_index(_btn)
{
    for (var i = 0; i < array_length(obj_input.bindings); i++)
    {
        if (obj_input.bindings[i][0] == _btn)
        {
            return i;
        }
    }
    
    return -1;
}

/// @param {Btn} _btn_mask (e.g. Btn.Left or Btn.Left | Btn.Right)
/// @param {real} _flags (e.g. InputState.HOLDING or InputState.HOLDING | InputState.RELEASED)
function check_input(_btn_mask, _flags)
{
    for (var i = 0; i < array_length(obj_input.bindings); i++)
    {
        var btn = obj_input.bindings[i][0];
        
        // Check if this binding is part of the requested mask
        if ((btn & _btn_mask) != 0)
        {
            if (has_flag(obj_input.input_state[i], _flags))
            {
                return true;
            }
        }
    }
    
    return false;
}