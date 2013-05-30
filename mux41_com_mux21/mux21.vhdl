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


entity and2 is 
	port (iA,iB :in bit;
			oZ :out bit);
end and2;

architecture atr_and2 of and2 is
begin
	oZ <= iA and iB ;
end atr_and2;


entity or2 is
	port (iA,iB :in bit;
			oZ :out bit);
end or2;

architecture atr_or2 of or2 is
begin 
	oZ <=iA or iB;
end atr_or2;
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
-- INICIO DA BATERIA DE TESTES


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
