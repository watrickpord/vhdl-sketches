-- SPI master testbench
library ieee;
use ieee.std_logic_1164.all;

entity spi_master_test is
end entity;

architecture behavioural of spi_master_test is
	-- DUT component
	component spi_master is
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
	end component;

	signal clk_in         : std_logic := '0';
	signal data_in        : std_logic_vector (7 downto 0);
	signal data_in_valid  : std_logic;
	signal data_out       : std_logic_vector (7 downto 0);
	signal data_out_valid : std_logic;
	signal clk_out        : std_logic;
	signal ss             : std_logic;
	signal mosi           : std_logic;
	signal miso           : std_logic;
begin
	spi_master_dut : spi_master port map (clk_in, data_in, data_in_valid, data_out, data_out_valid,
										  clk_out, ss, mosi, miso);


	-- infinite clock
	clk_in <= not clk_in after 1 ns;
	data_in <= "10101010";
	data_in_valid <= '1';
	miso <= '1', '0' after 11 ns;
end architecture behavioural;