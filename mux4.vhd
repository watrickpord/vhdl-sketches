-- 4 input multiplexer
library ieee;
use ieee.std_logic_1164.all;

entity mux4 is
    port (
        input  : in std_logic_vector (3 downto 0);
        ctrl   : in std_logic_vector (1 downto 0);
        output : out std_logic
    );
end mux4;

architecture behavioural of mux4 is
begin
    with ctrl select output <= input(3) when "11",
                               input(2) when "10",
                               input(1) when "01",
                               input(0) when "00",
                               'U' when others;
end behavioural;

architecture structural of mux4 is
begin
    output <= (ctrl(1) and ctrl(0) and input(3)) or
              (ctrl(1) and not ctrl(0) and input(2)) or
              (not ctrl(1) and ctrl(0) and input(1)) or
              (not ctrl(1) and not ctrl(0) and input(0));
end;