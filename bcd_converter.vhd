-- 14 bit binary to bcd converter
-- for algorithms see https://my.eng.utah.edu/~nmcdonal/Tutorials/BCDTutorial/BCDConversion.html
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bcd_converter is
    port (
        binary       : in  unsigned (13 downto 0);
        ones         : out unsigned (3 downto 0);
        tens         : out unsigned (3 downto 0);
        hundreds     : out unsigned (3 downto 0);
        thousands    : out unsigned (3 downto 0);
        tenthousands : out unsigned (3 downto 0)
    );
end bcd_converter;

architecture Behavioral of bcd_converter is
begin
    process (binary)
        -- 33 bit master register with concatenation of all bcd digits and binary number
        variable reg_main : std_logic_vector (33 downto 0);
    begin
        -- initial values into reg
        reg_main (13 downto 0)  := std_logic_vector(binary);
        reg_main (33 downto 14) := (others => '0');
        
        -- algorithm: if any columns >= 5, add 3, then bitshift left
        for i in 13 downto 0 loop
            -- add 3 to any columns >= 5
            -- ten thousands
            if unsigned(reg_main (33 downto 30)) >= 5 then
                reg_main (33 downto 30) := std_logic_vector(unsigned(reg_main (33 downto 30)) + 3);
            end if;
            -- thousands
            if unsigned(reg_main (29 downto 26)) >= 5 then
                reg_main (29 downto 26) := std_logic_vector(unsigned(reg_main (29 downto 26)) + 3);
            end if;
            -- hundreds
            if unsigned(reg_main (25 downto 22)) >= 5 then
                reg_main (25 downto 22) := std_logic_vector(unsigned(reg_main (25 downto 22)) + 3);
            end if;
            -- tens
            if unsigned(reg_main (21 downto 18)) >= 5 then
                reg_main (21 downto 18) := std_logic_vector(unsigned(reg_main (21 downto 18)) + 3);
            end if;
            -- ones
            if unsigned(reg_main (17 downto 14)) >= 5 then
                reg_main (17 downto 14) := std_logic_vector(unsigned(reg_main (17 downto 14)) + 3);
            end if;

            -- leftshift by one
            reg_main (33 downto 0) := reg_main (32 downto 0) & '0';          
        end loop;
        
        -- what's left in the columns of reg_main are the bcd values
        ones         <= unsigned(reg_main (17 downto 14));
        tens         <= unsigned(reg_main (21 downto 18));
        hundreds     <= unsigned(reg_main (25 downto 22));
        thousands    <= unsigned(reg_main (29 downto 26));
        tenthousands <= unsigned(reg_main (33 downto 30));
    end process;
end Behavioral;
