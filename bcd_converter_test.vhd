library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bcd_converter_test is
end bcd_converter_test;

architecture Behavioral of bcd_converter_test is
    component bcd_converter is
        port (
            binary       : in  unsigned (13 downto 0);
            ones         : out unsigned (3 downto 0);
            tens         : out unsigned (3 downto 0);
            hundreds     : out unsigned (3 downto 0);
            thousands    : out unsigned (3 downto 0);
            tenthousands : out unsigned (3 downto 0)
        );
    end component;
    
    signal binary       : unsigned (13 downto 0) := to_unsigned(0, 14);
    signal ones         : unsigned (3 downto 0);
    signal tens         : unsigned (3 downto 0);
    signal hundreds     : unsigned (3 downto 0);
    signal thousands    : unsigned (3 downto 0);
    signal tenthousands : unsigned (3 downto 0);
begin
    -- Instantiate DUT
    dut : bcd_converter port map (binary, ones, tens, hundreds, thousands, tenthousands);
    
    binary <= to_unsigned(162, 14) after 10 ns, to_unsigned(16132, 14) after 20 ns;

end Behavioral;
