-- 4_in_mux testbench
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity muxN_testbench is
end muxN_testbench;

architecture behavioural of muxN_testbench is
    -- Define muxN component
    component muxN is
        generic (
            num_bits : natural
        );
        port (
            -- for input we want range max unsigned of size num_bits to zero
            input  : in std_logic_vector (to_integer(shift_left(to_unsigned(1,num_bits+1), num_bits)-1) downto 0);
            ctrl   : in unsigned (num_bits-1 downto 0);
            output : out std_logic
        );
    end component;
    for muxN_0 : muxN use entity work.muxN;

    signal input  : std_logic_vector (3 downto 0);
    signal ctrl   : unsigned (1 downto 0);
    signal output : std_logic;
begin
    -- Instantiate DUT
    muxN_0 : muxN generic map (num_bits => 2) port map (input=>input, ctrl=>ctrl, output=>output);


    input <= "0001", "0010" after 40 ns, "0100" after 80 ns, "1000" after 120 ns;
    ctrl <= "00", "01" after 10 ns, "10" after 20 ns, "11" after 30 ns,
            "00" after 40 ns, "01" after 50 ns, "10" after 60 ns, "11" after 70 ns,
            "00" after 80 ns, "01" after 90 ns, "10" after 100 ns, "11" after 110 ns,
            "00" after 120 ns, "01" after 130 ns, "10" after 140 ns, "11" after 150 ns;
end;