-- 4 input ripple carry adder
library ieee;
use ieee.std_logic_1164.all;

entity ripple_adder_4 is
    port (
        a, b : in  std_logic_vector (3 downto 0);
        s : out std_logic_vector (3 downto 0);
        c_out : out std_logic
    );
end ripple_adder_4;

architecture structural of ripple_adder_4 is
    -- Full adder component
    component full_adder is
      port ( in_0, in_1, c_in : in std_logic;
             s, c_out : out std_logic );
    end component;
    --for full_adder use entity work.full_adder;

    signal c : std_logic_vector (4 downto 0);
begin
    -- Four single bit adders with carries connected
    adder_generator:
    for i in 3 downto 0 generate
        bit_adder : full_adder port map (in_0=>a(i), in_1=>b(i), c_in=>c(i), s=>s(i), c_out=>c(i+1));
    end generate;

    -- Overall carry outputs
    c(0)  <= '0';
    c_out <= c(4);
end architecture structural;