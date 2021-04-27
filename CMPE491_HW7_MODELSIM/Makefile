compile:
	python work.py
	vhdlan -full64 aes_128_tb.vhd aes_128.vhd keyXor_128.vhd sbox_128.vhd sbox.vhd shiftRow_128.vhd mixColumn_128.vhd mixColumn.vhd keyExpansion.vhd fault_injector.vhd
	vcs -full64 aes_128_tb

run: simv
	./simv

clean:
	rm -rf simv out.txt simv.daidir/ ucli.key work csrc/ synopsys_sim.setup 64
