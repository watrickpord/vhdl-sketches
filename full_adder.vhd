-- Synthesizable full adder
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
  port (in_0, in_1, c_in : in std_logic; s, c_out : out std_logic);
end full_adder;

architecture structural of full_adder is
begin
    -- Sum is xor of the 3 inputs
    s <= in_0 xor in_1 xor c_in;
    -- Carry high if 2 inputs are high
    c_out <= (in_0 and in_1) or (in_0 and c_in) or (in_1 and c_in);
end structural;
