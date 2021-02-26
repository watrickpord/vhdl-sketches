-- Testbench for 4 in adder(s)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_4_testbench is
end adder_4_testbench;

architecture behavioural of adder_4_testbench is
    -- Instantiate DUT
    component ripple_adder_4 is
        port (
            a, b : in  std_logic_vector (3 downto 0);
            s : out std_logic_vector (3 downto 0);
            c_out : out std_logic
        );
    end component;
    --for dut : ripple_adder_4 use work.ripple_adder_4;

    -- Signals
    signal a, b  : std_logic_vector (3 downto 0);
    signal s     : std_logic_vector (3 downto 0);
    signal c_out : std_logic;
begin
    -- Instantiate DUT
    dut : ripple_adder_4 port map (a, b, s, c_out);

    process
    begin
        -- Loop over all possible input combinations
        for i in 0 to 15 loop
            a <= std_logic_vector(to_unsigned(i, a'length));
            for j in 0 to 15 loop
                b <= std_logic_vector(to_unsigned(j, b'length));
                wait for 10 ns;
            end loop;
        end loop;

        -- Wait forever to end test
        wait;
    end process;
end;