library IEEE; 
use IEEE.std_logic_1164.all;

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
-- INICIO DA BATERIA DE TESTES
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
