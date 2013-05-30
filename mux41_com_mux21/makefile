all: mux41_com_mux21


vinversor:
	gtkwave teste_inversor.vcd &

vand:
	gtkwave teste_and.vcd &

vor:
	gtkwave teste_or.vcd &

vbuffer:
	gtkwave teste_buffer.vcd &

vmux21_1:
	gtkwave teste_mux21_1.vcd &

vmux21_2:
	gtkwave teste_mux21_2.vcd &

vmux21_4:
	gtkwave teste_mux21_4.vcd &

vmux21_8:
	gtkwave teste_mux21_8.vcd &

vmux41_com_mux21:
	gtkwave teste_mux41_com_mux21 &

vmux41_1:
	gtkwave teste_mux41_1.vcd &

vmux41_2:
	gtkwave teste_mux41_2.vcd &

vmux41_4:
	gtkwave teste_mux41_4.vcd &

vmux41_8:
	gtkwave teste_mux41_8.vcd &

vmux81_com_41:
	gtkwave teste_mux81_com_mux41 &



inversor:
	ghdl -a mux21.vhdl 
	ghdl -e teste_inversor
	ghdl -r teste_inversor --vcd=teste_inversor.vcd
	gtkwave teste_inversor.vcd &


and:
	ghdl -a mux21.vhdl 
	ghdl -e teste_and
	ghdl -r teste_and --vcd=teste_and.vcd
	gtkwave teste_and.vcd &

or:
	ghdl -a mux21.vhdl 
	ghdl -e teste_or
	ghdl -r teste_or --vcd=teste_or.vcd
	gtkwave teste_or.vcd &


mux21_1:
	ghdl -a mux21.vhdl 
	ghdl -e teste_mux21_1
	ghdl -r teste_mux21_1 --vcd=teste_mux21_1.vcd
	gtkwave teste_mux21_1.vcd &


mux21_2:
	ghdl -a mux21.vhdl 
	ghdl -e teste_mux21_2
	ghdl -r teste_mux21_2 --vcd=teste_mux21_2.vcd
	gtkwave teste_mux21_2.vcd &


mux21_4:
	ghdl -a mux21.vhdl 
	ghdl -e teste_mux21_4
	ghdl -r teste_mux21_4 --vcd=teste_mux21_4.vcd
	gtkwave teste_mux21_4.vcd &


mux21_8:
	ghdl -a mux21.vhdl 
	ghdl -e teste_mux21_8
	ghdl -r teste_mux21_8 --vcd=teste_mux21_8.vcd
	gtkwave teste_mux21_8.vcd &


mux41_com_mux21:
	ghdl -a mux21.vhdl 
	ghdl -e teste_mux41_com_mux21
	ghdl -r teste_mux41_com_mux21 --vcd=teste_mux41_com_mux21.vcd
	gtkwave teste_mux41_com_mux21.vcd &

compilatudo:
	echo "criando executaveis"
	ghdl -a mux21.vhdl 
	ghdl -e teste_inversor
	ghdl -r teste_inversor --vcd=teste_inversor.vcd
	ghdl -e teste_inversorf
	ghdl -r teste_inversorf --vcd=teste_inversorf.vcd
	ghdl -e teste_and
	ghdl -r teste_and --vcd=teste_and.vcd
	ghdl -e teste_andf
	ghdl -r teste_andf --vcd=teste_andf.vcd
	ghdl -e teste_or
	ghdl -r teste_or --vcd=teste_or.vcd
	ghdl -e teste_buffer
	ghdl -r teste_buffer --vcd=teste_buffer.vcd
	ghdl -e teste_mux21_1
	ghdl -r teste_mux21_1 --vcd=teste_mux21_1.vcd
	ghdl -e teste_mux21_2
	ghdl -r teste_mux21_2 --vcd=teste_mux21_2.vcd
	ghdl -e teste_mux21_4
	ghdl -r teste_mux21_4 --vcd=teste_mux21_4.vcd
	ghdl -e teste_mux21_8
	ghdl -r teste_mux21_8 --vcd=teste_mux21_8.vcd
	ghdl -e teste_mux41_com_mux21
	ghdl -r teste_mux41_com_mux21 --vcd=teste_mux41_com_mux21.vcd
	ghdl -e teste_mux41_1
	ghdl -r teste_mux41_1 --vcd=teste_mux41_1.vcd
	ghdl -e teste_mux41_2
	ghdl -r teste_mux41_2 --vcd=teste_mux41_2.vcd
	ghdl -e teste_mux41_4
	ghdl -r teste_mux41_4 --vcd=teste_mux41_4.vcd
	ghdl -e teste_mux41_8
	ghdl -r teste_mux41_8 --vcd=teste_mux41_8.vcd
	ghdl -e teste_mux81_com_mux41
	ghdl -r teste_mux81_com_mux41 --vcd=teste_mux81_com_mux41.vcd
	rm -f *.o
	rm -f teste
	rm -f teste_inversor
	rm -f teste_and
	rm -f teste_or
	rm -f teste_mux21_1
	rm -f teste_mux21_2
	rm -f teste_mux21_4
	rm -f teste_mux21_8
	rm -f teste_mux41_com_mux21
	
limpao:
	rm -f *.o

limpaexecutaveis:
	rm -f teste
	rm -f teste_inversor
	rm -f teste_and
	rm -f teste_or
	rm -f teste_mux21_1
	rm -f teste_mux21_2
	rm -f teste_mux21_4
	rm -f teste_mux21_8
	rm -f teste_mux41_com_mux21

limpatudo:
	rm -f *.o
	rm -f *.vcd
	rm -f teste
	rm -f teste_inversor
	rm -f teste_and
	rm -f teste_or
	rm -f teste_mux21_1
	rm -f teste_mux21_2
	rm -f teste_mux21_4
	rm -f teste_mux21_8
	rm -f teste_mux41_com_mux21
	rm -f teste_mux21_1.vcd
	rm -f teste_mux21_2.vcd
	rm -f teste_mux21_4.vcd
	rm -f teste_mux21_8.vcd
	rm -f teste_mux41_com_mux21.vcd

inf:
	echo " --INFORMACOES--"
	echo "make - compila todos os arquivos e apaga os arquivos .o"
	echo "make v'nome do arquivo' - executa no gtkwave"
	echo "make 'nome do que vai ser testado' - compila e executa o programa no gtkwave"
	echo "make limpao - apaga os arquivos .o"
	echo "make limpatudo - apaga todos os executaveis e .o"
