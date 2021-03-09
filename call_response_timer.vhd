-- call and response timer for HC-SR04 acoustic ranger module
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity call_response_timer is
    port (
        clk_1MHz  : in  std_logic;
        clk_pulse : in  std_logic;
        call      : out std_logic;
        response  : in  std_logic;
        time_val  : out unsigned (13 downto 0);
        new_time  : out std_logic
    );
end call_response_timer;

architecture Behavioral of call_response_timer is
    type states is (init, call_count, response_count, done, waiting);
    signal state : states := init;
    signal counter : unsigned (13 downto 0);
begin
    process (clk_1Mhz) is
    begin
        if rising_edge(clk_1MHz) then
            if state = init then
                call     <= '1';
                counter <= to_unsigned(0, 14);
                -- next state
                state <= call_count;
            elsif state = call_count then
                -- count up to make sure pulse if sent for 10uS
                if counter < 100 then
                    counter <= counter + 1;
                else
                    -- at the end of the call pulse, pull down pulse
                    -- reset counter and advance to response counter
                    call    <= '0';
                    counter <= to_unsigned(0, 14);
                    state   <= response_count;
                end if;
            elsif state = response_count then
                -- check for response or timeout, if none increment counter
                if response = '1' or counter = "11111111111111" then
                    state <= done;
                else
                    counter <= counter + 1;
                end if;
            elsif state = done then
                time_val <= counter;
                new_time <= '1';
                state <= waiting;
            else
                -- state = waitintg: wait for clk_pulse
                new_time <= '0';
                
                if clk_pulse = '1' then
                    state <= init;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
