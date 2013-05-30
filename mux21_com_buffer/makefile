all: inversorf

vinverosrf:
	gtkwave teste_inversorf.vcd &

vadnf:
	gtkwave teste_andf.vcd &

vbuffer:
	gtkwave teste_buffer.vcd &

inversorf:
	ghdl -a muxbuffer_3_estados.vhdl
	ghdl -e teste_inversorf
	ghdl -r teste_inversorf --vcd=teste_inversorf.vcd
	gtkwave teste_inversorf.vcd &


andf:
	ghdl -a muxbuffer_3_estados.vhdl
	ghdl -e teste_andf
	ghdl -r teste_andf --vcd=teste_andf.vcd
	gtkwave teste_andf.vcd &


buffer:
	ghdl -a muxbuffer_3_estados.vhdl
	ghdl -e teste_buffer
	ghdl -r teste_buffer --vcd=teste_buffer.vcd
	gtkwave teste_buffer.vcd &


buffer_2bits:
	ghdl -a muxbuffer_3_estados.vhdl
	ghdl -e teste_buffer_2bits
	ghdl -r teste_buffer_2bits --vcd=teste_buffer_2bits.vcd
	gtkwave teste_buffer_2bits.vcd &


buffer_4bits:
	ghdl -a muxbuffer_3_estados.vhdl
	ghdl -e teste_buffer_4bits
	ghdl -r teste_buffer_4bits --vcd=teste_buffer_4bits.vcd
	gtkwave teste_buffer_4bits.vcd &


buffer_8bits:
	ghdl -a muxbuffer_3_estados.vhdl
	ghdl -e teste_buffer_8bits
	ghdl -r teste_buffer_8bits --vcd=teste_buffer_8bits.vcd
	gtkwave teste_buffer_8bits.vcd &


compilatudo:
	echo "criando executaveis"
	ghdl -a muxbuffer_3_estados.vhdl
	ghdl -e teste_inversorf
	ghdl -r teste_inversorf --vcd=teste_inversorf.vcd
	ghdl -e teste_andf
	ghdl -r teste_andf --vcd=teste_andf.vcd
	ghdl -e teste_buffer
	ghdl -r teste_buffer --vcd=teste_buffer.vcd
	rm -f *.o
	rm -f teste
	rm -f teste_inversorf
	rm -f teste_andf
	rm -f teste_buffer

limpao:
	rm -f *.o

limpaexecutaveis:
	rm -f teste
	rm -f teste_inversorf
	rm -f teste_and2
	rm -f teste_buffer
	
limpatudo:
	rm -f *.o
	rm -f *.vcd
	rm -f teste
	rm -f teste_inversorf
	rm -f teste_and
	rm -f teste_buffer

inf:
	echo " --INFORMACOES--"
	echo "make - compila todos os arquivos e apaga os arquivos .o"
	echo "make v'nome do arquivo' - executa no gtkwave"
	echo "make 'nome do que vai ser testado' - compila e executa o programa no gtkwave"
	echo "make limpao - apaga os arquivos .o"
	echo "make limpatudo - apaga todos os executaveis e .o"
