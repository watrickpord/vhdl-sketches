-- Dot product test bench
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.array_package.all;


entity dot_product_test is
end dot_product_test;

architecture behavioral of dot_product_test is
    -- DUT component
    component dot_product is
        generic (
            num_bits  : natural;
            dimension : natural
        );
        port (
            a : in array_type (dimension-1 downto 0) (num_bits-1 downto 0);
            b : in array_type (dimension-1 downto 0) (num_bits-1 downto 0);
            result : out signed (num_bits-1 downto 0)
        );
    end component;
    
     signal a : in array_type (dimension-1 downto 0) (num_bits-1 downto 0);
     signal b : in array_type (dimension-1 downto 0) (num_bits-1 downto 0);
     signal result : out signed (num_bits-1 downto 0);
begin
    -- Instantiate DUT
    dot_product_dut : dot_product generic map (num_bits => 4, dimension => 3)
                                  port map (a, b, result);

    -- Apply test signals
    a <= (0 => 1, 1 => 1, 2 => 1);
    a <= (0 => 1, 1 => 2, 2 => 3);
end behavioral;
