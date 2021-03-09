library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity call_response_timer_test is
end call_response_timer_test;

architecture Behavioral of call_response_timer_test is
    component call_response_timer is
        port (
            clk_1MHz  : in  std_logic;
            clk_pulse : in  std_logic;
            call      : out std_logic;
            response  : in  std_logic;
            time_val  : out unsigned (13 downto 0);
            new_time  : out std_logic
        );
    end component;
    
    signal clk_1MHz  : std_logic := '1';
    signal clk_pulse : std_logic := '0';
    signal call      : std_logic;
    signal response  : std_logic := '0';
    signal time_val  : unsigned (13 downto 0);
    signal new_time  : std_logic;
begin
    -- Instantiate DUT
    DUT : call_response_timer port map (clk_1MHz=>clk_1MHz, clk_pulse=>clk_pulse, call=>call,
                                        response=>response, time_val=>time_val, new_time=>new_time);

    clk_1MHz <= not clk_1MHz after 500 ns;
    
    response <= '1' after 500 us, '0' after 600 us;
    clk_pulse <= '1' after 1000 us, '0' after 1001 us;
end Behavioral;
