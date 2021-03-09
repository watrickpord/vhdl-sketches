library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seven_segment_decoder is
    generic (
        is_common_anode : boolean := false          -- inverts the output
    );
    port (
        input  : in  std_logic_vector (3 downto 0);
        output : out std_logic_vector (0 to 6)      -- a = 0 to g = 6
    );
end seven_segment_decoder;

architecture Behavioral of seven_segment_decoder is
    signal seven_seg_code : std_logic_vector (6 downto 0);
begin
    -- seven segment code (for common cathode i.e. high = light)
    with input select seven_seg_code <= "1111110" when "0000",
                                        "0110000" when "0001",
                                        "1101101" when "0010",
                                        "1111001" when "0011",
                                        "0110011" when "0100",
                                        "1011011" when "0101",
                                        "1011111" when "0110",
                                        "1110000" when "0111",
                                        "1111111" when "1000",
                                        "1111011" when "1001",
                                        "0000000" when others;
                                        
    -- use either seven_seg_code or its inverse depending on mode
    common_cathode : if not is_common_anode generate
        output <= seven_seg_code;
    end generate;
    
    common_anode : if is_common_anode generate
        output <= not seven_seg_code;
    end generate;
end Behavioral;
