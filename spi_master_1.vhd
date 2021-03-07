-- SPI master
library ieee;
use ieee.std_logic_1164.all;

entity spi_master is
	port (
		clk_in         : in  std_logic;
		data_in        : in  std_logic_vector (7 downto 0);
		data_in_valid  : in  std_logic;
		data_out       : out std_logic_vector (7 downto 0);
		data_out_valid : out std_logic;
		clk_out        : out std_logic;
		ss             : out std_logic;
		mosi           : out std_logic;
		miso           : in  std_logic
	);
end spi_master;

architecture behavioural of spi_master is
	type states is (init, tx, finished);
	signal transmitting : std_logic;
	signal state : states := init;
	signal data_reg : std_logic_vector (7 downto 0);
	signal counter  : natural;
begin
	process (clk_in)
	begin
		-- output data on rising edge (mode 1 spi)
		if rising_edge(clk_in) then
			if state = init then
				-- output assignments
				clk_out <= '0';
				ss <= '1';
				transmitting <= '0';
				mosi <= '0';
				counter <= 7;
				data_reg <= data_in;
				data_out_valid <= '0';

				-- next state?
				if data_in_valid = '1' then
					state <= tx;
				end if;
			elsif state = tx then
				-- output assignments
				clk_out <= '1';
				ss <= '0';
				transmitting <= '1';
				mosi <= data_reg(counter);
				data_out_valid <= '0';

				-- next state?
				if counter = 0 then
					state <= finished;
				else
					counter <= counter - 1;
					state <= tx;
				end if;
			else
				-- finished state
				clk_out <= '0';
				ss <= '1';
				transmitting <= '0';
				mosi <= '0';
				data_out <= data_reg;
				data_out_valid <= '1';

				state <= init;
			end if;
		else
			-- falling edge of clk_in
			clk_out <= '0';

			-- receive data into data_reg (overwrites previously sent bit)
			if state = tx and transmitting = '1' then
				data_reg(counter+1) <= miso;
			end if;
		end if;
	end process;
end architecture behavioural;