local link = 0x1EF460
local global = 0x3E6CF0
local actor = 0x3FFFA0

function AL(a, s) return A(link+a, s) end
function AG(a, s) return A(global+a, s) end
function AA(a, s) return A(actor+a, s) end

local common = dofile("A common.lua")

return merge(common, {
    checksum            = AL(0x138E, 2),
    --disable_pause       = AL(, 1),
    --hookshot_ba         = AL(, 1),
    --disable_c_buttons_2 = AL(, 1),
    --disable_items       = AL(, 1),
    --rock_sirloin        = AL(, 1),
    --sword_disabler      = AL(, 1),
    --bubble_timer        = AL(, 2),
    rupee_accumulator   = AL(0x4078, 2),
    spring_water_timers = AL(0x41D8, 0xC0),
    spring_water_time_1 = AL(0x41F8, 0x20),
    spring_water_time_2 = AL(0x4218, 0x20),
    spring_water_time_3 = AL(0x4238, 0x20),
    spring_water_time_4 = AL(0x4258, 0x20),
    spring_water_time_5 = AL(0x4278, 0x20),
    spring_water_time_6 = AL(0x4298, 0x20),
    pictograph_picture  = AL(0x1390, 0x2BC0),
    title_screen_mod    = AL(0x3F5C, 4),
    --entrance_mod        = AL(, 4),
    timer_crap          = AL(0x408C, 4),
    timer_x             = AL(0x41B8, 2),
    timer_y             = AL(0x41C6, 2),
    buttons_enabled     = AL(0x429C, 4),
    magic_modifier      = AL(0x42AC, 4),
    magic_max           = AL(0x42B2, 2),
    weird_a_graphic     = AL(0x42CE, 1),
    --target_style        = AL(, 1),
    --music_mod           = AL(, 2),
    --entrance_mod_setter = AL(, 2),
    title_screen_thing  = AL(0x42D8, 1),
    --transition_mod      = AL(, 2),
    suns_song_effect    = AL(0x42E4, 2),
    health_mod          = AL(0x42E6, 2),
    screen_scale_enable = AL(0x42EC, 1),
    screen_scale        = AL(0x42F0, 'f'),
    --scene_flags_ingame  = AL(, 0x960),

    --random              = A(, 4),
    --visibility          = A(, 2),
    stored_epona        = A(0x1B892F, 1),
    stored_song         = A(0x1C18ED, 1),
    --buttons_3           = A(, 2),
    --buttons_4           = A(, 2),

    --text_open           = A(, 1),
    --text_status         = A(, 1),
    room_number         = A(0x3FF3B0, 1),
    room_ptr            = A(0x3FF3BC, 4),
    --actor_disable       = A(, 2),
    --warp_begin          = A(, 1),
    --screen_dim          = A(, 1),
    --warp_destination    = A(, 2),
})
