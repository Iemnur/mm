[button_L]: 0x0020
[button_R]: 0x0010
[button_any]: 0x0F20

[min_actor_no]: 0

[hold_delay_amount]: 3

spawn:
    push    4, s0, s1, s2, s3, s4, ra,
    li      t1, @global_context
    lhu     s0, anum
    lw      s1, hold_delay
    lhu     s2, @buttons_offset(t1)
    lhu     s3, avar
    lw      s4, selected
// set selected
//  andi    t2, s2, @button_R
    srl     s4, s2, 4
    andi    s4, s4, 1
// handle hold delay
    andi    t4, s2, @button_any
    bnez    t4, +
    addi    s1, s1, 1
    li      s1, 0
+:
    beqi    s1, 1, +
    nop
    subi    t4, s1, @hold_delay_amount
    bltz    t4, return
    nop
+: // handle dpad
    bnez    s4, +
    mov     a1, s2
    call    dpad_control, s0, a1
    mov     s0, v0
    b       ++
    nop
+:
    call    dpad_control, s3, a1
    andi    s3, v0, 0xFFFF
+: // set min/max on actor number
    subi    t4, s0, @min_actor_no
    bgez    t4, +
    nop
    li      s0, @max_actor_no
+:
    subi    t4, s0, @max_actor_no
    blez    t4, +
    nop
    li      s0, @min_actor_no
+: // spawn
    andi    t3, s2, @button_L
    beqz    t3, return
    nop
    mov     a0, s0
    mov     a1, s3
    bal     simple_spawn
    nop
return:
// render actor number
    call    simple_text, 0x0001001C, 0x88CCFFFF, fmt, s0
// render actor variable
    call    simple_text, 0x0006001C, 0xFFCC88FF, fmt, s3
// done
    sh      s0, anum
    sw      s1, hold_delay
    sh      s3, avar
    sw      s4, selected
    ret     4, s0, s1, s2, s3, s4, ra,

anum:
    .word 0
avar:
    .word 0
selected:
    .word 0

fmt:
    .asciiz "%04X"
.align

.include "dpad control.asm"
.include "simple spawn.asm"
.include "simple text.asm"

hold_delay:
    .word 0

object_spawn_wrap:
    // a0: object table
    // a1: object number
    beqz    a0, +
    nop
    beqi    a0, 1, +
    nop
    beqi    a0, 2, +
    nop
    call    @object_spawn, a0, a1
+:
    jr
    nop

.org @object_index
    // a0: object table
    // a1: object number
    // we have space for 22 instructions (on debug, 23 on 1.0?)
    push    4, ra, 1
    mov     t0, a0
    lbu     t1, 8(a0) // remaining items
    cl      v0
-:
    lh      t2, 12(t0) // item's object number
// t2 = abs(t2)
    bgez    t2, +
    nop
    subu    t2, r0, t2
+:
    beq     a1, t2, +
    subi    t1, t1, 1
    addiu   v0, v0, 1
    addi    t0, t0, 68
    bnez    t1, -
    nop
    call    @object_spawn, a0, a1
    //subiu   v0, r0, -1 // original code
+:
    ret     4, ra, 1
