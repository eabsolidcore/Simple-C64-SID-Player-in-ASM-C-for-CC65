.export _SIDINIT
.export SIDSTEP 
.export _SIDFILE
.export _SIDPLAY
_SIDFILE: .INCBIN "filename.sid",$7e

SIDLOADPOS = $4000;
SIDPLAYPOS = $4003;

SIDSTEP: 
	jsr SIDPLAYPOS
	rts 

_SIDINIT: 
	lda #0 
	tax 
	tay 
	jsr SIDLOADPOS
	rts 

_SIDPLAY:
	LDX #<IRQ	;lo-byte
	LDY #>IRQ	;hi-byte
	STX $031	
	STY $0315
	LDA #$00
	STA $D012
	LDA #$7F
	STA $DC0D
	LDA #$1B
	STA $D011
	LDA #$01
	STA $D01A
	CLI
	RTS

IRQ:
	INC $D019
	LDA #$00
	STA $D012	

	JSR SIDSTEP	;Step the SID
	JMP $EA7E	;Back to Rom
	
