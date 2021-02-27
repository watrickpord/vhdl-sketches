-- N input multiplexer with generic for N size
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity muxN is
    generic (
        num_bits : natural
    );
    port (
        -- for input we want range max unsigned of size num_bits, to zero
        input  : in std_logic_vector (to_integer(shift_left(to_unsigned(1,num_bits+1), num_bits)-1) downto 0);
        ctrl   : in unsigned (num_bits-1 downto 0);
        output : out std_logic
    );
end muxN;

architecture behavioural of muxN is
begin
    -- Note we have to add 1 to ctrl due to 1 based indexing
    -- (given that we can't subtract to get N-1 in definition)
    output <= input(to_integer(ctrl));
end;