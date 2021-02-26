-- 4_in_mux testbench
library ieee;
use ieee.std_logic_1164.all;

entity mux4_testbench is
end mux4_testbench;

architecture behavioural of mux4_testbench is
	-- Define 4mux component
	component mux4 is
		port (
			input  : in std_logic_vector (3 downto 0);
			ctrl   : in std_logic_vector (1 downto 0);
			output : out std_logic
		);
	end component;
	for mux4_0 : mux4 use entity work.mux4;

	signal input  : std_logic_vector (3 downto 0);
	signal ctrl   : std_logic_vector (1 downto 0);
	signal output : std_logic;
begin
	-- Instantiate DUT
	mux4_0 : mux4 port map (input=>input, ctrl=>ctrl, output=>output);


	input <= "0001", "0010" after 40 ns, "0100" after 80 ns, "1000" after 120 ns;
	ctrl <= "00", "01" after 10 ns, "10" after 20 ns, "11" after 30 ns,
			"00" after 40 ns, "01" after 50 ns, "10" after 60 ns, "11" after 70 ns,
			"00" after 80 ns, "01" after 90 ns, "10" after 100 ns, "11" after 110 ns,
			"00" after 120 ns, "01" after 130 ns, "10" after 140 ns, "11" after 150 ns;
end;