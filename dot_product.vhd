-- Dot product calculator

-- define an array type for input vectors
library IEEE; use IEEE.NUMERIC_STD.ALL;
package array_package is
    type array_type is array(natural range <>) of signed;
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.array_package.all;


entity dot_product is
    generic (
        num_bits  : natural;
        dimension : natural
    );
    port (
        a : in array_type (dimension-1 downto 0) (num_bits-1 downto 0);
        b : in array_type (dimension-1 downto 0) (num_bits-1 downto 0);
        result : out signed (num_bits-1 downto 0)
    );
end dot_product;

architecture behavioral of dot_product is
    signal product_array : array_type (dimension-1 downto 0) (num_bits-1 downto 0);
    signal sum_array     : array_type (dimension-1 downto 0) (num_bits-1 downto 0);
begin
    -- elementwise product array
    gen_prod_array : for i in range 0 to dimension-1 generate
        product_array(i) <= a(i) * b(i);
    end generate;
    
    -- sum up product array
    sum_array(0) <= product_array(0);
    sum_prod_array : for i in range 1 to dimension-1 generate
        sum_array(i) <= sum_array(i-1) + product_array(i);
    end generate;
    
    -- end result of sum_array ripple is output
    result <= sum_array(dimension-1);
end behavioral;
