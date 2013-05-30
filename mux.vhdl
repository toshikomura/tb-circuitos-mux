library IEEE; 
use IEEE.std_logic_1164.all;

entity inv is
	port (iA :in bit;
			oZ :out bit);
end inv;

architecture atr_inv of inv is
begin
	oZ <= not iA ;
end atr_inv;

--not com std_logic
library IEEE;
use IEEE.std_logic_1164.all;
entity invf is
	port (iA :in std_logic;
			oZ :out std_logic);
end invf;

architecture atr_invf of invf is
begin
	oZ <= not iA ;
end atr_invf;


entity and2 is 
	port (iA,iB :in bit;
			oZ :out bit);
end and2;

architecture atr_and2 of and2 is
begin
	oZ <= iA and iB ;
end atr_and2;

--and com std_logic
library IEEE;
use IEEE.std_logic_1164.all;
entity and2f is 
	port (iA,iB :in std_logic;
			oZ :out std_logic);
end and2f;

architecture atr_and2f of and2f is
begin
	oZ <= iA and iB	;
end atr_and2f;


entity or2 is
	port (iA,iB :in bit;
			oZ :out bit);
end or2;

architecture atr_or2 of or2 is
begin 
	oZ <=iA or iB;
end atr_or2;

--MUX COM BUFFER DE 3 ESTADOS 
library IEEE;
use IEEE.std_logic_1164.all;
entity buffer_3_estados is
	port (s, iA, iB:in std_logic;
			oZ :out std_logic);
end buffer_3_estados;

architecture atr_buffer_3_estados of buffer_3_estados is
	component porta_not port(iA :in std_logic;
									 oZ :out std_logic);
	end component;
	component porta_and port(iA, iB :in std_logic;
									 oZ :out std_logic);
	end component;
	for all: porta_not use entity work.invf(atr_invf);
	for all: porta_and use entity work.and2f(atr_and2f);
	signal ns, x:STD_LOGIC;
begin
	g0 : porta_not port map (s, ns);
	g1 : porta_and port map (ns, iA, oZ);
	g2 : porta_and port map (s, iB, oZ);
end atr_buffer_3_estados;

 
library IEEE;
use IEEE.std_logic_1164.all;
entity buffer_3_estados_2bits is
	port (s :in std_logic;
			iA, iB :in std_logic_vector(1 downto 0);
			oZ :out std_logic_vector(1 downto 0));
end buffer_3_estados_2bits;

architecture atr_buffer_3_estados_2bits of buffer_3_estados_2bits is
	component buffer_3_1bit port(s, 
										  iA, iB :in std_logic;
									 	  oZ :out std_logic);
	end component;
	for all: buffer_3_1bit use entity work.buffer_3_estados(atr_buffer_3_estados);
	signal ns, x :std_logic;
begin
	g0 : buffer_3_1bit port map (s, iA(0), iB(0), oZ(0));
	g1 : buffer_3_1bit port map (s, iA(1), iB(1), oZ(1));
end atr_buffer_3_estados_2bits;

 
library IEEE;
use IEEE.std_logic_1164.all;
entity buffer_3_estados_4bits is
	port (s :in std_logic;
			iA, iB :in std_logic_vector(3 downto 0);
			oZ :out std_logic_vector(3 downto 0));
end buffer_3_estados_4bits;

architecture atr_buffer_3_estados_4bits of buffer_3_estados_4bits is
	component buffer_3_2bits 	port (s :in std_logic;
												iA, iB :in std_logic_vector(1 downto 0);
												oZ :out std_logic_vector(1 downto 0));
	end component;
	for all: buffer_3_2bits use entity work.buffer_3_estados_2bits(atr_buffer_3_estados_2bits);
	signal ns, x :std_logic_vector(1 downto 0);
begin
	g0 : buffer_3_2bits port map (s, iA(1 downto 0), iB(1 downto 0), oZ(1 downto 0));
	g1 : buffer_3_2bits port map (s, iA(3 downto 2), iB(3 downto 2), oZ(3 downto 2));
end atr_buffer_3_estados_4bits;


library IEEE;
use IEEE.std_logic_1164.all;
entity buffer_3_estados_8bits is
	port (s :in std_logic;
			iA, iB :in std_logic_vector(7 downto 0);
			oZ :out std_logic_vector(7 downto 0));
end buffer_3_estados_8bits;

architecture atr_buffer_3_estados_8bits of buffer_3_estados_8bits is
	component buffer_3_4bits port (s :in std_logic;
											 iA, iB :in std_logic_vector(3 downto 0);
											 oZ :out std_logic_vector(3 downto 0));
	end component;
	for all: buffer_3_4bits use entity work.buffer_3_estados_4bits(atr_buffer_3_estados_4bits);
	signal ns, x :std_logic_vector(3 downto 0);
begin
	g0 : buffer_3_4bits port map (s, iA(3 downto 0), iB(3 downto 0), oZ(3 downto 0));
	g1 : buffer_3_4bits port map (s, iA(7 downto 4), iB(7 downto 4), oZ(7 downto 4));
end atr_buffer_3_estados_8bits;
-- FIM DO BUFFER DE 3 ESTADOS COM 8 BITS
-- INICIO MUX 2:1 --
--MUX 2:1 que recebe 1bit em cada entrada
entity mux21 is
	port (S, iA, iB :in bit; -- 1 entrada de controle
			oZ :out bit);
end mux21;

architecture atr_mux21 of mux21 is
	component porta_not port (iA :in bit; 
									 oZ :out bit);
	end component; 
	component porta_and port (iA, iB :in bit;
												  oZ :out bit);
	end component;
	component porta_or port (iA, iB :in bit;
												 oZ :out bit);
	end component;
	for all: porta_not use entity work.inv (atr_inv);
	for all: porta_and use entity work.and2 (atr_and2);
	for all: porta_or use entity work.or2 (atr_or2);
	signal ns, y, w: bit;
begin
	g0 : porta_not port map (S, ns);
	g1 : porta_and port map (ns, iA, y);
	g2 : porta_and port map (S, iB, w);
	g3 : porta_or port map (y, w, oZ);
end atr_mux21;

--MUX 2:1 encadeados que recebe 2bits de cada entrada
entity mux21_dual is
	port (S :bit;
			iA, iB: bit_vector(1 downto 0);
			oZ	:out bit_vector(1 downto 0));
end mux21_dual;

architecture atr_mux21_dual of mux21_dual is
	component mux21_1_Bit port (S, iA, iB :in bit;
								 oZ :out bit);
	end component;
	for all : mux21_1_Bit use entity work.mux21(atr_mux21);
begin
	g0 : mux21_1_Bit port map (S, iA(0), iB(0), oZ(0));
	g1 : mux21_1_Bit port map (S, iA(1), iB(1), oZ(1));
end atr_mux21_dual;

--MUX 2:1 encadeados que recebe 4bits de cada entrada
entity mux21_quad is
	port (S :in bit;
			iA, iB :in bit_vector(3 downto 0);
			oZ :out bit_vector(3 downto 0));
end mux21_quad;

architecture atr_mux21_quad of mux21_quad is
	component mux21_2_Bits port (S :in bit;
										iA, iB :in bit_vector(1 downto 0);
										oZ :out bit_vector(1 downto 0));
	end component;	
	for all : mux21_2_Bits use entity work.mux21_dual(atr_mux21_dual);
begin
	g0 : mux21_2_Bits port map (S, iA(1 downto 0), iB(1 downto 0), oZ(1 downto 0));
	g2 : mux21_2_Bits port map (S, iA(3 downto 2), iB(3 downto 2), oZ(3 downto 2));
end atr_mux21_quad;

--MUX 2:1 encadeados que recebe 8bits de cada entrada
entity mux21_eighth is
	port (S :in bit;
			iA, iB :in bit_vector(7 downto 0);
			oZ :out bit_vector(7 downto 0));
end mux21_eighth;

architecture atr_mux21_eighth of mux21_eighth is
	component mux21_4_Bits port (S :in bit;
										iA, iB :in bit_vector(3 downto 0);
										oZ :out bit_vector(3 downto 0));
	end component;	
	for all : mux21_4_Bits use entity work.mux21_quad(atr_mux21_quad);
begin
	g0 : mux21_4_Bits port map (S, iA(3 downto 0), iB(3 downto 0), oZ(3 downto 0));
	g2 : mux21_4_Bits port map (S, iA(7 downto 4), iB(7 downto 4), oZ(7 downto 4)); 
end atr_mux21_eighth;

--FINAL MUX 41 implementado com mux21
entity mux41_com_mux21 is
	port (s1, s2 :in bit;
			iA, iB, iC, iD :in bit_vector(7 downto 0);
			oZ :out bit_vector(7 downto 0));
end mux41_com_mux21;

architecture atr_mux41_com_mux21 of mux41_com_mux21 is
	component mux21_com_8bits port (s :in bit;
											  iA, iB :in bit_vector(7 downto 0);
											  oZ :out bit_vector(7 downto 0));
	end component;
	for all: mux21_com_8bits use entity work.mux21_eighth(atr_mux21_eighth);
	signal oZ1, oZ2 :bit_vector(7 downto 0);
begin
	g0 : mux21_com_8bits port map (s2, iA, iB, oZ1);
	g1 : mux21_com_8bits port map (s2, iC, iD, oZ2);
	g2 : mux21_com_8bits port map (s1, oZ1, oZ2, oZ);
end atr_mux41_com_mux21;

-- FIM DO MUX 2:1 --
-- INICIO DO MUX 4:1 --
entity mux41_1 is
	port (s1, s2 :in bit; -- 2 entradas de controle
			iA, iB, iC, iD :in bit;
			oZ :out bit);
end mux41_1;

architecture atr_mux41_1 of mux41_1 is
	component porta_not port (iA :in bit; 
									  oZ :out bit);
	end component; 
	component porta_and port (iA, iB :in bit;
									  oZ :out bit);
	end component;
	component porta_or port (iA, iB :in bit;
									 oZ :out bit);
	end component;
	for all: porta_not use entity work.inv (atr_inv);
	for all: porta_and use entity work.and2 (atr_and2);
	for all: porta_or use entity work.or2 (atr_or2);
	signal ns1, ns2, s1s2, ns1s2, s1ns2, ns1ns2, y1, y2, y3, y4, y1y2, y3y4: bit;
begin --obtendo as negacoes das entradas de controle
	g0 : porta_not port map (s1, ns1);
	g1 : porta_not port map (s2, ns2);
	--fazendo "and" das entradas de controle com as entradas  
	g2 : porta_and port map (s1, s2, s1s2);
	g3 : porta_and port map (ns1, s2, ns1s2);
	g4 : porta_and port map (s1, ns2, s1ns2);
	g5 : porta_and port map (ns1, ns2, ns1ns2);
	g6 : porta_and port map (ns1ns2, iA, y1);
	g7 : porta_and port map (s1ns2, iB, y2);
	g8 : porta_and port map (ns1s2, iC, y3);
	g9 : porta_and port map (s1s2, iD, y4);
	-- "or" dos "and"s anteriores
	g10 : porta_or port map (y1, y2, y1y2);
	g11 : porta_or port map (y3, y4, y3y4);
	g12 : porta_or port map (y1y2, y3y4, oZ);
end atr_mux41_1;

--MUX 4:1 encadeados que recebe 2bits de cada entrada
entity mux41_dual is
	port (s1, s2 :in bit;
			iA, iB, iC, iD :in bit_vector(1 downto 0);
			oZ :out bit_vector(1 downto 0));
end mux41_dual;

architecture atr_mux41_dual of mux41_dual is
	component mux41_1_Bit port (s1, s2, iA, iB, iC, iD :in bit;
										 oZ :out bit);
	end component;
	for all : mux41_1_Bit use entity work.mux41_1(atr_mux41_1);	
begin
	g0 : mux41_1_Bit port map (s1, s2, iA(0), iB(0), iC(0), iD(0), oZ(0));
	g1 : mux41_1_Bit port map (s1, s2, iA(1), iB(1), iC(1), iD(1), oZ(1));
end atr_mux41_dual;

--MUX 4:1 encadeados que recebe 4bits de cada entrada
entity mux41_quad is
	port (s1, s2 :in bit;
			iA, iB, iC, iD :in bit_vector(3 downto 0);
			oZ :out bit_vector(3 downto 0));
end mux41_quad;

architecture atr_mux41_quad of mux41_quad is
	component mux41_2_Bits port (s1, s2 :in bit;
										  iA, iB, iC, iD :in bit_vector(1 downto 0);
										  oZ :out bit_vector(1 downto 0));
	end component;	
	for all : mux41_2_Bits use entity work.mux41_dual(atr_mux41_dual);
begin
	g0 : mux41_2_Bits port map (s1, s2, iA(1 downto 0), iB(1 downto 0), iC(1 downto 0), iD(1 downto 0), oZ(1 downto 0));
	g2 : mux41_2_Bits port map (s1, s2, iA(3 downto 2), iB(3 downto 2), iC(3 downto 2), iD(3 downto 2), oZ(3 downto 2)); 
end atr_mux41_quad;

--MUX 4:1 encadeados que recebe 8bits de cada entrada
entity mux41_eighth is
	port (s1, s2 :in bit;
			iA, iB, iC, iD :in bit_vector(7 downto 0);
			oZ :out bit_vector(7 downto 0));
end mux41_eighth;

architecture atr_mux41_eighth of mux41_eighth is
	component mux41_4_Bits port (s1, s2 :in bit;
										iA, iB, iC, iD :in bit_vector(3 downto 0);
										oZ :out bit_vector(3 downto 0));
	end component;	
	for all : mux41_4_Bits use entity work.mux41_quad(atr_mux41_quad);
begin
	g0 : mux41_4_Bits port map (s1, s2, iA(3 downto 0), iB(3 downto 0), iC(3 downto 0), iD(3 downto 0), oZ(3 downto 0));
	g2 : mux41_4_Bits port map (s1, s2, iA(7 downto 4), iB(7 downto 4), iC(7 downto 4), iD(7 downto 4), oZ(7 downto 4)); 
end atr_mux41_eighth;

--FINAL MUX81 implementado com MUX41
entity mux81_com_mux41 is
	port (s1, s2, s3 :in bit;
			iA, iB, iC, iD, iE, iG, iH, iJ :in bit_vector(7 downto 0);
			oZ :out bit_vector(7 downto 0));
end mux81_com_mux41;

architecture atr_mux81_com_mux41 of mux81_com_mux41 is
	component mux41_com_8bits port (s1, s2 :in bit;
											  iA, iB, iC, iD :in bit_vector(7 downto 0);
											  oZ :out bit_vector(7 downto 0));
	end component;
	component mux21_com_8bits port (s :in bit;
							  				  iA, iB :in bit_vector(7 downto 0);
							  				  oZ :out bit_vector(7 downto 0));
	end component;
	for all: mux41_com_8bits use entity work.mux41_eighth(atr_mux41_eighth);
	for all: mux21_com_8bits use entity work.mux21_eighth(atr_mux21_eighth);
	signal oZ1, oZ2 :bit_vector(7 downto 0);
begin
	g0 : mux41_com_8bits port map (s1, s2, iA, iB, iC, iD, oZ1);
	g1 : mux41_com_8bits port map (s1, s2, iE, iG, iH, iJ, oZ2);
	g2 : mux21_com_8bits port map (s3, oZ1, oZ2, oZ);
end atr_mux81_com_mux41;
-- FIM DO MUX 4:1 --
--BATERIA DE TESTES --
--teste o inversor 
entity teste_inversor is
end teste_inversor;

architecture atr_teste_inversor of teste_inversor is
	component inversor port (iA :in bit;
									 oZ :out bit);
	end component;
	for all : inversor use entity work.inv(atr_inv);
	signal entrada, saida: bit;
begin
	g0 : inversor port map (entrada, saida);
	entrada <= '1',
		'0' after 5 ns,
		'1' after 15 ns,
		'0' after 25 ns,
		'1' after 35 ns;
end atr_teste_inversor;

--teste inversorf
library IEEE;
use IEEE.std_logic_1164.all;
entity teste_inversorf is
end teste_inversorf;

architecture atr_teste_inversorf of teste_inversorf is
	component inversorf port (iA :in std_logic;
									 oZ :out std_logic);
	end component;
	for all : inversorf use entity work.invf(atr_invf);
	signal entrada, saida: std_logic;
begin
	g0 : inversorf port map (entrada, saida);
	entrada <= '1',
		'0' after 5 ns,
		'1' after 15 ns,
		'0' after 25 ns,
		'1' after 35 ns;
end atr_teste_inversorf;

--teste da porta and
entity teste_and is
end teste_and;

architecture atr_teste_and of teste_and is
	component porta_and port (iA, iB :in bit;
									 oZ :out bit);
	end component;
	for all : porta_and use entity work.and2(atr_and2);
	signal en1, en2, saida: bit;
begin
	g0 : porta_and port map (en1, en2, saida);
	en1 <= '1',
		'0' after 5 ns,
		'1' after 15 ns,
		'0' after 25 ns,
		'1' after 35 ns;
	en2 <= '1',
		'0' after 5 ns,
		'1' after 15 ns,
		'0' after 35 ns;
end atr_teste_and;

--teste da porta andf
library IEEE;
use IEEE.std_logic_1164.all;
entity teste_andf is
end teste_andf;

architecture atr_teste_andf of teste_andf is
	component porta_andf port (iA, iB :in std_logic;
									 oZ :out std_logic);
	end component;
	for all : porta_andf use entity work.and2f(atr_and2f);
	signal en1, en2, saida: std_logic;
begin
	g0 : porta_andf port map (en1, en2, saida);
	en1 <= '1',
		'0' after 5 ns,
		'1' after 15 ns,
		'0' after 25 ns,
		'1' after 35 ns;
	en2 <= '1',
		'0' after 5 ns,
		'1' after 15 ns,
		'0' after 35 ns;
end atr_teste_andf;

--teste da porta or
entity teste_or is
end teste_or;

architecture atr_teste_or of teste_or is
	component porta_ou port (iA, iB:in bit;
									 oZ :out bit);
	end component;
	for all : porta_ou use entity work.or2(atr_or2);
	signal en1, en2, saida: bit;
begin
	g0 : porta_ou port map (en1, en2, saida);
	en1 <= '1',
		'0' after 5 ns,
		'1' after 15 ns,
		'0' after 25 ns,
		'1' after 35 ns;
	en2 <= '1',
		'0' after 5 ns,
		'1' after 15 ns,
		'0' after 35 ns;
end atr_teste_or;

--teste do buffer
library IEEE;
use IEEE.std_logic_1164.all;
entity teste_buffer is
end teste_buffer;

architecture atr_teste_buffer of teste_buffer is
	component buffer_3 port (s, iA, iB :in std_logic;
									 oZ :out std_logic);
	end component;
	for all: buffer_3 use entity work.buffer_3_estados(atr_buffer_3_estados);
	signal s, en1, en2, saida:std_logic;
begin
	g0 : buffer_3 port map (en1, en2, saida);
	s <= '1',
		  '0' after 25 ns;
	en1 <='1',
		 '0' after 20 ns,
		 '1' after 40 ns;
	en2 <='1',
		 '0' after 30 ns;
end atr_teste_buffer;

library IEEE;
use IEEE.std_logic_1164.all;
entity teste_buffer_2bits is
end teste_buffer_2bits;

architecture atr_teste_buffer_2bits of teste_buffer_2bits is
	component buffer_3 port (s :in std_logic;
									 iA, iB :in std_logic_vector(1 downto 0);
									 oZ :out std_logic_vector(1 downto 0));
	end component;
	for all: buffer_3 use entity work.buffer_3_estados_2bits(atr_buffer_3_estados_2bits);
	signal s :std_logic;
	signal en1, en2, saida :std_logic_vector(1 downto 0) ;
begin
	g0 : buffer_3 port map (s, en1, en2, saida);
	s <= '1', 
			 '0' after 30 ns;
	en1 <= "00",
			 "11" after 35 ns,
			 "00" after 50 ns;
	en2 <= "11",
			 "00" after 5 ns,
			 "11" after 20 ns;
end atr_teste_buffer_2bits;


library IEEE;
use IEEE.std_logic_1164.all;
entity teste_buffer_4bits is
end teste_buffer_4bits;

architecture atr_teste_buffer_4bits of teste_buffer_4bits is
	component buffer_3 port (s :in std_logic;
									 iA, iB :in std_logic_vector(3 downto 0);
									 oZ :out std_logic_vector(3 downto 0));
	end component;
	for all: buffer_3 use entity work.buffer_3_estados_4bits(atr_buffer_3_estados_4bits);
	signal s :std_logic;
	signal en1, en2, saida :std_logic_vector(3 downto 0) ;
begin
	g0 : buffer_3 port map (s, en1, en2, saida);
	s <= '1', 
			 '0' after 30 ns;
	en1 <= "1010",
			 "1111" after 35 ns,
			 "1010" after 45 ns,
			 "0000" after 50 ns;
	en2 <= "1111",
			 "0000" after 5 ns,
			 "1111" after 20 ns;
end atr_teste_buffer_4bits;

library IEEE;
use IEEE.std_logic_1164.all;
entity teste_buffer_8bits is
end teste_buffer_8bits;

architecture atr_teste_buffer_8bits of teste_buffer_8bits is
	component buffer_3 port (s :in std_logic;
									 iA, iB :in std_logic_vector(7 downto 0);
									 oZ :out std_logic_vector(7 downto 0));
	end component;
	for all: buffer_3 use entity work.buffer_3_estados_8bits(atr_buffer_3_estados_8bits);
	signal s :std_logic;
	signal en1, en2, saida :std_logic_vector(7 downto 0);
begin
	g0 : buffer_3 port map (s, en1, en2, saida);
	s <= '1', 
			 '0' after 30 ns;
	en1 <= "00000000",
			 "10101010" after 10 ns,
			 "00000000" after 20 ns,
			 "11111111" after 35 ns,
			 "00000000" after 50 ns;
	en2 <= "11111111",
			 "00000000" after 5 ns,
			 "11111111" after 20 ns,
			 "10101010" after 45 ns;
end atr_teste_buffer_8bits;
-- fim do teste do buffer

--teste da mux21 com 1 bit para cada entrada
entity teste_mux21_1 is
end teste_mux21_1;

architecture atr_teste_mux21_1 of teste_mux21_1 is
	component MUX port (S, iA, iB :in bit;
							  oZ :out bit);
	end component;
	for all: MUX use entity work.mux21(atr_mux21);
	signal Set, en1, en2, saida: bit;
begin
	g0 : MUX port map (Set, en1, en2, saida);
	Set <= '1', 
			 '0' after 30 ns;
	en1 <= '0',
			 '1' after 35 ns,
			 '0' after 50 ns;
	en2 <= '1',
			 '0' after 5 ns,
			 '1' after 20 ns;
end atr_teste_mux21_1;

--teste da mux21 com 2 bits em cada entrada
entity teste_mux21_2 is
end teste_mux21_2;

architecture atr_teste_mux21_2 of teste_mux21_2 is
	component MUX port (S :in bit; 
							  iA, iB :in bit_vector(1 downto 0);
							  oZ :out bit_vector(1 downto 0));
	end component;
	for all: MUX use entity work.mux21_dual(atr_mux21_dual);
	signal Set: bit;
	signal en1, en2, saida: bit_vector (1 downto 0);
begin
	g0 : MUX port map (Set, en1, en2, saida);
	Set <= '1', 
			 '0' after 30 ns;
	en1 <= "00",
			 "11" after 35 ns,
			 "00" after 50 ns;
	en2 <= "11",
			 "00" after 5 ns,
			 "11" after 20 ns;
end atr_teste_mux21_2;

--teste do mux21 com 4 bits em cada entrada
entity teste_mux21_4 is
end teste_mux21_4;

architecture atr_teste_mux21_4 of teste_mux21_4 is
	component MUX port (S :in bit;
							  iA, iB :in bit_vector(3 downto 0);
							  oZ :out bit_vector(3 downto 0));
	end component;
	for all: MUX use entity work.mux21_quad(atr_mux21_quad);
	signal Set :bit;
	signal en1, en2, saida: bit_vector(3 downto 0);
begin
	g0 : MUX port map (Set, en1, en2, saida);
	Set <= '1', 
			 '0' after 30 ns;
	en1 <= "1010",
			 "1111" after 35 ns,
			 "1010" after 45 ns,
			 "0000" after 50 ns;
	en2 <= "1111",
			 "0000" after 5 ns,
			 "1111" after 20 ns;
end atr_teste_mux21_4;

--teste do mux21 com 8 bits em cada entrada
entity teste_mux21_8 is
end teste_mux21_8;

architecture atr_teste_mux21_8 of teste_mux21_8 is
	component MUX port (S :in bit;
							  iA, iB :in bit_vector(7 downto 0);
							  oZ :out bit_vector(7 downto 0));
	end component;
	for all: MUX use entity work.mux21_eighth(atr_mux21_eighth);
	signal Set :bit;
	signal en1, en2, saida: bit_vector(7 downto 0);
begin
	g0 : MUX port map (Set, en1, en2, saida);
	Set <= '1', 
			 '0' after 30 ns;
	en1 <= "00000000",
			 "10101010" after 10 ns,
			 "00000000" after 20 ns,
			 "11111111" after 35 ns,
			 "00000000" after 50 ns;
	en2 <= "11111111",
			 "00000000" after 5 ns,
			 "11111111" after 20 ns,
			 "10101010" after 45 ns;
end atr_teste_mux21_8;


--teste final para MUX41 implementado com mux21
entity teste_mux41_com_mux21 is
end teste_mux41_com_mux21;

architecture atr_teste_mux41_com_mux21 of teste_mux41_com_mux21 is
	component MUX port (s1, s2 :in bit;
							  iA, iB, iC, iD :in bit_vector(7 downto 0);
							  oZ :out bit_vector(7 downto 0));
	end component;
	for all: MUX use entity work.mux41_com_mux21(atr_mux41_com_mux21);
	signal s1, s2 :bit;
	signal en1, en2, en3, en4, saida: bit_vector(7 downto 0);
begin
	g0 : MUX port map (s1, s2, en1, en2, en3, en4, saida);
	s1 <= '1', 
			 '0' after 40 ns;
	s2 <= '1', 
			 '0' after 20 ns,
			 '1' after 40 ns,
			 '0' after 60 ns,
			 '1' after 80 ns;
	en1 <= "10101010",
			 "01010101" after 40 ns;
	en2 <= "11110000";
	en3 <= "00000000",
			 "11111111" after 35 ns,
			 "10010010" after 50 ns;
	en4 <= "11111111",
			 "00000000" after 5 ns,
			 "11111111" after 20 ns;
end atr_teste_mux41_com_mux21;

--teste do mux41 com 1 bit em cada entrada
entity teste_mux41_1 is
end teste_mux41_1;

architecture atr_teste_mux41_1 of teste_mux41_1 is
	component MUX port (s1, s2, iA, iB, iC, iD :in bit;
							  oZ :out bit);
	end component;
	for all: MUX use entity work.mux41_1(atr_mux41_1);
	signal s1, s2, en1, en2, en3, en4, saida: bit;
begin
	g0 : MUX port map (s1, s2, en1, en2, en3, en4, saida);
	s1 <= '1',
			'0' after 10 ns,
			'1' after 20 ns,
			'0' after 30 ns;
	s2 <= '1', 
			'0' after 20 ns;
	en1 <= '0',
			 '1' after 15 ns,
			 '0' after 40 ns,
			 '1' after 45 ns,
			 '0' after 50 ns;
	en2 <= '1',
			 '0' after 5 ns,
			 '1' after 10 ns,
			 '0' after 15 ns,
			 '1' after 20 ns;
	en3 <= '0',
			 '1' after 35 ns,
			 '0' after 50 ns;
	en4 <= '1',
			 '0' after 5 ns,
			 '1' after 20 ns,
			 '0' after 25 ns,
			 '1' after 35 ns;
end atr_teste_mux41_1;

--teste do mux41 com 2 bits em cada entrada
entity teste_mux41_2 is
end teste_mux41_2;

architecture atr_teste_mux41_2 of teste_mux41_2 is
	component MUX port (s1, s2 :in bit; 
							  iA, iB, iC, iD :in bit_vector(1 downto 0);
							  oZ :out bit_vector(1 downto 0));
	end component;
	for all: MUX use entity work.mux41_dual(atr_mux41_dual);
	signal s1, s2: bit;
	signal en1, en2, en3, en4, saida: bit_vector (1 downto 0);

begin
	g0 : MUX port map (s1, s2, en1, en2, en3, en4, saida);
	s1 <= '1',
			'0' after 10 ns,
			'1' after 20 ns,
			'0' after 30 ns;
	s2 <= '1', 
			'0' after 20 ns;
	en1 <= "00",
			 "11" after 35 ns,
			 "00" after 50 ns;
	en2 <= "11",
			 "00" after 5 ns,
			 "11" after 20 ns;
	en3 <= "00",
			 "11" after 35 ns,
			 "00" after 50 ns;
	en4 <= "11",
			 "00" after 5 ns,
			 "11" after 20 ns;
end atr_teste_mux41_2;

--teste do mux41 com 4 bits em cada entrada
entity teste_mux41_4 is
end teste_mux41_4;

architecture atr_teste_mux41_4 of teste_mux41_4 is
	component MUX port (s1, s2 :in bit;
							  iA, iB, iC, iD :in bit_vector(3 downto 0);
							  oZ :out bit_vector(3 downto 0));
	end component;
	for all: MUX use entity work.mux41_quad(atr_mux41_quad);
	signal s1, s2 :bit;
	signal en1, en2, en3, en4, saida: bit_vector(3 downto 0);
begin
	g0 : MUX port map (s1, s2, en1, en2, en3, en4, saida);
		s1 <= '1',
			'0' after 10 ns,
			'1' after 20 ns,
			'0' after 30 ns;
	s2 <= '1', 
			'0' after 20 ns;
	en1 <= "0000",
			 "1111" after 35 ns,
			 "1010" after 45 ns,
			 "0000" after 50 ns,
			 "0101" after 60 ns,
			 "0101" after 70 ns;
	en2 <= "1111",
			 "1010" after 5 ns,
			 "0111" after 45 ns;
	en3 <= "0010",
			 "1111" after 35 ns,
			 "0000" after 50 ns;
	en4 <= "1111",
			 "0000" after 5 ns,
			 "1111" after 20 ns;
end atr_teste_mux41_4;

--teste do mu41 com 8 bits em cada entrada
entity teste_mux41_8 is
end teste_mux41_8;

architecture atr_teste_mux41_8 of teste_mux41_8 is
	component MUX port (s1, s2 :in bit;
							  iA, iB, iC, iD :in bit_vector(7 downto 0);
							  oZ :out bit_vector(7 downto 0));
	end component;
	for all: MUX use entity work.mux41_eighth(atr_mux41_eighth);
	signal s1, s2 :bit;
	signal en1, en2, en3, en4, saida: bit_vector(7 downto 0);
begin
	g0 : MUX port map (s1, s2, en1, en2, en3, en4, saida);
	s1 <= '1',
			'0' after 10 ns,
			'1' after 20 ns,
			'0' after 30 ns;
	s2 <= '1', 
			'0' after 20 ns;
	en1 <= "00000000",
			 "11111111" after 35 ns,
			 "00000000" after 50 ns,
			 "01010101" after 70 ns;
	en2 <= "11111111",
			 "00000000" after 5 ns,
			 "11010111" after 20 ns;
	en3 <= "01001000",
			 "11111111" after 35 ns,
			 "00000000" after 50 ns;
	en4 <= "11111111",
			 "00000000" after 5 ns,
			 "11111111" after 20 ns;
end atr_teste_mux41_8;


--teste final para MUX41 implementado com mux21
entity teste_mux81_com_mux41 is
end teste_mux81_com_mux41;

architecture atr_teste_mux81_com_mux41 of teste_mux81_com_mux41 is
	component MUX port (s1, s2, s3:in bit;
							  iA, iB, iC, iD, iE, iG, iH, iJ:in bit_vector(7 downto 0);
							  oZ :out bit_vector(7 downto 0));
	end component;
	for all: MUX use entity work.mux81_com_mux41(atr_mux81_com_mux41);
	signal s1, s2, s3 :bit;
	signal en1, en2, en3, en4, en5, en6, en7, en8, saida: bit_vector(7 downto 0);
begin
	g0 : MUX port map (s1, s2, s3, en1, en2, en3, en4, en5, en6, en7, en8, saida);
	s1 <= '1', 
			 '0' after 80 ns,
			 '1' after 200 ns;
	s2 <= '1', 
			 '0' after 40 ns,
			 '1' after 60 ns,
			 '0' after 100 ns,
			 '1' after 140 ns,
			 '0' after 180 ns;
	s3 <= '1', 
			 '0' after 20 ns,
			 '1' after 40 ns,
			 '0' after 60 ns,
			 '1' after 80 ns,
			 '0' after 100 ns,
			 '1' after 120 ns,
			 '0' after 140 ns,
			 '1' after 160 ns,
			 '0' after 180 ns; 
	en1 <= "10101010";
	en2 <= "11110000";
	en3 <= "00000100";
	en4 <= "11111111";
	en5 <= "10101010";
	en6 <= "11110000";
	en7 <= "00010100";
	en8 <= "01101111";
end atr_teste_mux81_com_mux41;
