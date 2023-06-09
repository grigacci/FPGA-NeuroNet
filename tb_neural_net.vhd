library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;

entity tb_neural_net is
end tb_neural_net;

architecture rtl of tb_neural_net is

    component neural_net 
        port (
            pixel : in std_logic_vector(data_size - 1 downto 0);
            addr  : in std_logic_vector(address_size - 1 downto 0);
            clk   : in std_logic;
            --valid_in : in std_logic;
    
            output : out std_logic_vector(3 downto 0);
            clk_o  : out std_logic
        );
        end component; 

        signal clock : std_logic;
        signal pixel_in : std_logic_vector(data_size - 1 downto 0);
        signal addr_in : std_logic_vector(address_size - 1 downto 0);
        signal output_o : std_logic_vector(3 downto 0);

        constant PERIOD    : time := 20 ns;
        constant DUTY_CYCLE : real := 0.5;
        constant OFFSET     : time := 5 ns;


begin

    instance : neural_net 
    port map (
        pixel => pixel_in,
        addr => addr_in,
        clk => clock,
        output => output_o
    );

    gen_clock: process
    begin
		wait for OFFSET;
		CLOCK_LOOP : loop
			clock <= '1';
			wait for (PERIOD - (PERIOD * DUTY_CYCLE));
			clock <= '0';
			wait for (PERIOD * DUTY_CYCLE);
		end loop CLOCK_LOOP;
	end process;



end architecture;